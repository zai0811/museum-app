class DepartmentsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[ index  ]
  skip_before_action :authorize_user!, only: %i[ index  ]

  def index
    @deparments = Department.all
  end
end
