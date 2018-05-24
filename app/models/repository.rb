class Repository < ApplicationRecord
	belongs_to :user


	def search_on_github(username, repo)
		begin
			Octokit.repo("#{username}/#{repo}")
		rescue
			nil
		end
	end
end
