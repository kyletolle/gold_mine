class GoldMine
  AMOUNT_MINED_PER_HOUR = 3600
  SECONDS_PER_HOUR      = 3600

  attr_reader :last_collected_at

  def initialize
    @mining = false
    @last_collected_at = nil
  end

  def begin_mining
    unless mining?
      @mining = true
      update_last_collected_at
    end
  end

  def update_last_collected_at
    @last_collected_at = current_time
  end

  def mining?
    @mining
  end

  def amount_uncollected
    if mining?
      (current_time - last_collected_at)*(AMOUNT_MINED_PER_HOUR/SECONDS_PER_HOUR)
    end
  end

  def collect_gold
    if mining?
      amount_uncollected.
        tap { update_last_collected_at }
    end
  end

private
  def current_time
    Time.now.to_i
  end
end

