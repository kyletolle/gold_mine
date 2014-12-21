# gold_mine

This simulates a gold mine that, once mining begins, accumulates gold at a
rate of 1 unit per second. You can collect the gold, and the amount
accumulated resets, but it will continue to accumulate gold.

## Usage

```
require './lib/gold_mine'

mine = GoldMine.new
mine.begin_mining
# Wait a few seconds
mine.amount_uncollected # => 3
mine.collect_gold       # => 3
mine.last_collected_at  # => 1419180548
mine.amount_uncollected # => 0
```

## Development

### Install

```
bundle install path=.bundle
```

### Run

```
rspec
```

## License

MIT

