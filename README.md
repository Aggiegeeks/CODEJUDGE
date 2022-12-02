
This project is the continuation of the Legacy Code Judge project which was created earlier in Spring 2022. 

Client : Ritchey
TA :  Mayukh RoyChowdhury, Ravi Pranjal

Members of the project :

1. Gokul Sai Doppalapudi
2. Rajendra Thottempudi
3. Shyam Prasad Nagulavancha
4. Aravind Badavath
5. Chandu Akula
6. Chetan Nc 


Proposed New Functionalities for this semester :

1. Tagging for different types of Problems
2. Sorting and searching with tags
3. Ability to add new test cases 
4. Differentiating between Instructor and Student Profiles
5. Ability to group students and provide Group statistics
6. Providing ability for Instructors to create groups of students and problems
7. Activating and Deactivating test cases

Local Development:

Because CodeJudge is in a Docker container, starting up the application is very simple. First, make sure Docker is installed and running on your machine.

After cloning the repository, place the master.key file in the config directory. After that, navigate to the codejudge directory and initialize the container by running the shell command

					docker-compose build
					
If this command returns an error, make sure Docker is running. This step may take a while if it’s your first time building the container, but in later
iterations Docker caches many of the components it needs. Once the container is built, run the shell command 
					
					docker-compose run web rails db:create db:schema:load db:seed
					
This command initializes the database, loads the schema from schema.rb, then seeds the database with fake data as specified in seed.rb.Once the database has been built and seeded, run the shell command

					docker-compose up
					
If you want to recreate the container from scratch later, run

					docker-compose down -v
					
Environment variables are handled with the Figaro gem. You’ll need to set your environment variables in the application.yml file. You will need to
set your domain as an environment variable as well as your glot.io API key.

Other variables are:
• RAILS_MASTER_KEY & SECRET_KEY_BASE: have to be set in Heroku
under Settings → Config Vars
• RACK_ENV & RAILS_ENV: set to production
• RAILS_SERVE_STATIC_FILES: set to enabled
• GLOT_KEY: get by registering for the glot.io API
• DOMAIN: your app domain, e.g. appname.herokuapp.com
• REDIS_URL_SIDEKIQ: has to be the same as the REDIS_URL that is set


Deploying to Heroku:

First, download and install the Heroku CLI. Run the command

		heroku login
		
Once you’re logged in, you can log into the Heroku container registry with

		heroku container:login
		
To deploy your container, you must be in the directory with your Docker image have already built the image. If it is the first time deploying to heroku
you have to add the Heroku Postgres and Heroku Redis Add-On first. To push the container to Heroku, run

		heroku container:push web sidekiq --recursive
		
Then, to deploy your changes to the production site, run

		heroku container:release web sidekiq


Again, if it is the first time deploying, the sidekiq dyno should now show up under the Resources tab on Heroku. If so, go ahead and enable it.
Since the Heroku database is the production database you do not have to create it first. All you have to do after you pushed the container is running migrations on the production database. If it is the first time, do

		heroku run rails db:schema:load db:seed
		
For future deployment, just do

		heroku run rails db:migrate
		
And you’re done!
