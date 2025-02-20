# Configura o Faker para usar a localidade em português
Faker::Config.locale = 'pt-BR'

puts "Limpando base de dados..."
Enrollment.delete_all
Attendance.delete_all
Course.delete_all
Student.delete_all
Professional.delete_all
User.delete_all
School.delete_all

puts "Criando Escolas..."
schools = []
3.times do
  schools << School.create!(
    name: Faker::Educator.university,
    address: Faker::Address.full_address
  )
end

puts "Criando Gerentes de Unidade..."
schools.each do |school|
  User.create!(
    email: Faker::Internet.email(name: "gerente_#{school.name.parameterize(separator: '_')}"),
    password: 'password',
    role: 'manager_unit',
    school: school
  )
end

puts "Criando Gerente Geral..."
User.create!(
  email: "gerente_geral@example.com",
  password: 'password',
  role: 'manager_general'
)

puts "Criando Profissionais..."
professionals = []
10.times do
  professionals << Professional.create!(
    name: Faker::Name.name,
    profession: Faker::Job.field
  )
end

puts "Criando Cursos..."
courses = []
schools.each do |school|
  3.times do
    courses << Course.create!(
      name: "Curso de #{Faker::Educator.subject}",
      start_date: Faker::Date.between(from: 1.year.ago, to: Date.today),
      end_date: Faker::Date.between(from: Date.today, to: 1.year.from_now),
      school: school
    )
  end
end

puts "Criando Alunos..."
students = []
100.times do
  students << Student.create!(
    name: Faker::Name.name,
    birth_date: Faker::Date.birthday(min_age: 10, max_age: 18)
  )
end

puts "Criando Matrículas..."
enrollments = []
students.each do |student|
  # Cada aluno se matricula em 1 ou 2 cursos aleatórios
  courses.sample(rand(1..2)).each do |course|
    enrollments << Enrollment.create!(
      student: student,
      course: course,
      created_by: User.where(role: 'manager_unit').sample.id,
      enrollment_date: Faker::Date.backward(days: 365)
    )
  end
end

puts "Criando Atendimentos..."
enrollments.each do |enrollment|
  Attendance.create!(
    student: enrollment.student,
    professional: professionals.sample,
    school: enrollment.course.school,
    date: Faker::Date.backward(days: 30),
    start_time: Faker::Time.backward(days: 30, period: :morning),
    end_time: Faker::Time.backward(days: 30, period: :afternoon),
    observations: Faker::Lorem.sentence(word_count: 10),
    created_by: enrollment.created_by
  )
end

puts "Seeds finalizados com sucesso!"
