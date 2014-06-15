module BaseballStats

def battingAverage(hits, at_bats)
    if  at_bats.nonzero?
      avg=(hits.to_f/at_bats.to_f).round(3)
    end

end

def sluggingPercentage(hits, doubles, triples, home_runs, at_bats)
  if at_bats.nonzero?
    pct=((hits - doubles - triples - home_runs) + (2 * doubles) + (3 * triples) + (4 * home_runs))/at_bats
  end
end

end
