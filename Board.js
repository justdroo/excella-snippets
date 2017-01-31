class Board extends Component {
  dropdown(method){
      if (method === "editing") {
        return (
          <div>
            <Col lg={11} md={11} sm={11} xs={11}>
              <form className="spaceTopS" onSubmit={this.handleEditTitle.bind(this)}>
                <FormGroup>
                  <ControlLabel>Edit Title</ControlLabel>
                  <FormControl type="text" onChange={this.handleTitleChange.bind(this)} value={this.state.title} />
                </FormGroup>
                <Button type='submit'>Edit</Button>
              </form>
            </Col>
          </div>
        )
      } else {
        return(<div></div>)
    }

    render() {
    let dropdownEdit = this.dropdown(this.props.editing);
    return (
      <Row>
        <Col lg={6} md={6} sm={6} xs={6}>
          <Button onClick={this.handleEditDropdown.bind(this)}>
            <span className="glyphicon glyphicon-cog" aria-hidden="true" value="editing"></span>
          </Button>

          {dropdownEdit}

        </Col>
      </Row>
    )

}
