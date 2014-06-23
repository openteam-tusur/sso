Warden::Manager.after_authentication do |user, auth, opts|
  user.share_user
end
