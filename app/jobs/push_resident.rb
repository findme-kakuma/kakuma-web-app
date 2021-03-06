class PushResident < Que::Job
  # Default settings for this job. These are optional - without them, jobs
  # will default to priority 100 and run immediately.
  @priority = 10
  @run_at = proc { 1.minute.from_now }

  def run(resident_id, _options = {})
    resident = Resident.find resident_id

    ActiveRecord::Base.transaction do
      # Write any changes you'd like to the database.
      urls = if Figaro.env.urls_to_push_resident?
               JSON.parse(Figaro.env.urls_to_push_resident)
             else []
             end
      urls.each do |url|
        @result = HTTParty.post url,
                                body: Api::V1::ResidentSerializer.new(
                                  resident
                                ).to_json,
                                headers: {
                                  'Content-Type' => 'application/json'
                                }
        puts @result
      end

      # It's best to destroy the job in the same transaction as any other
      # changes you make. Que will destroy the job for you after the run
      # method if you don't do it yourself, but if your job writes to the
      # DB but doesn't destroy the job in the same transaction, it's
      # possible that the job could be repeated in the event of a crash.
      destroy
    end
  end
end
