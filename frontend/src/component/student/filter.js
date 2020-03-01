import React, { useState } from 'react';
import { connect } from 'react-redux';
import { loadSchoolData } from '../../reducers/schoolReducer';
import { makeStyles } from '@material-ui/core/styles';

const useStyles = makeStyles({
    root: {
        minWidth: 275,
    },
    bullet: {
        display: 'inline-block',
        margin: '0 2px',
        transform: 'scale(0.8)',
    },
    title: {
        fontSize: 14,
    },
    pos: {
        marginBottom: 12,
    },
});

const FilterCard = (props) => {

    const {loadSchoolList} = props;

    const classes = useStyles();

    const [filterParam, setFilter] = useState(null)

    const handleSubmit = (e) => {
        e.preventDefault()
        const params = {"name": filterParam}
        loadSchoolList(params)
    }

    return (
        <form onSubmit={handleSubmit}>
            <input type="text" name="filter" values={filterParam} onChange={(e) => { setFilter(e.target.value) }} />
            <input type="submit"/>
        </form>
    );
}

const mapDispatch = (dispatch) => {
    return {
        loadSchoolList: (prarms) => dispatch(loadSchoolData(prarms))
    }
}
export default connect(null, mapDispatch)(FilterCard);