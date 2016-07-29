require 'spec_helper'


describe 'Rendering a Graphviz SVG' do

  def app
    $app
  end

  let(:dot) do
    <<-EOF
      digraph G {
        main -> parse -> execute;
        main -> init;
        main -> cleanup;
        execute -> make_string;
        execute -> printf
        init -> make_string;
        main -> printf;
        execute -> compare;
      }
    EOF
  end

  it 'renders an empty response with a 422 when no valid params are supplied' do
    get '/'
    expect(last_response.status).to be(422)
    expect(last_response.body).to be_empty
  end

  it 'renders an SVG from supplied content' do
    get '/', dot: dot
    expect(last_response).to be_ok
    expect(last_response.body).to include('Generated by graphviz')
  end

  it 'renders an SVG from a URL' do
    url = 'http://www.example.com/test.dot'
    stub_request(:any, url).to_return(status: 200, body: dot)
    get '/', url: url
    expect(last_response).to be_ok
    expect(last_response.body).to include('Generated by graphviz')
  end
end
