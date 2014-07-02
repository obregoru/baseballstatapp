class PlayerMailer <ActionMailer::Base
  default from: 'info@baseballstats.com'
  
  def notify_award(player, award)
    @player=player
    mail(to: @player.email, subject: 'You\'ve won an award! ', body: ' You have won the ' + award.award_name)
  
  end
end
