import React, { useState, useEffect } from 'react';
import { connect } from 'react-redux';
import Header from './header';
import List from './list';
import { loadSchoolDetails, loadSchoolData } from '../../reducers/schoolReducer';
import CssBaseline from '@material-ui/core/CssBaseline';
import Grid from '@material-ui/core/Grid';
import Container from '@material-ui/core/Container';
import { makeStyles } from '@material-ui/core/styles';
import Divider from '@material-ui/core/Divider';
import clsx from 'clsx';
import Paper from '@material-ui/core/Paper';
import FilterCard from './filter';

const useStyles = makeStyles(theme => ({
    mainGrid: {
        marginTop: theme.spacing(3),
    },
    paper: {
        padding: theme.spacing(2),
        display: 'flex',
        overflow: 'auto',
        flexDirection: 'column',
    },
    fixedHeight: {
        height: 240,
    },
}));


const Profile = (props) => {
    const { session, schoolList} = props;
    const classes = useStyles();
    const fixedHeightPaper = clsx(classes.paper, classes.fixedHeight);

    return (
        <React.Fragment>
            <CssBaseline />
            <Container maxWidth="xl">
                <main>
                    <Header post={session} />
                    <FilterCard/>
                    <Grid container item xs={12} md={4} lg={3} className={classes.mainGrid}>
                        {schoolList&&schoolList.map(item => (
                            <React.Fragment>
                                <Divider />
                                <List key={item.id} post={item} />
                            </React.Fragment>
                        ))}
                    </Grid>
                </main>
            </Container>
        </React.Fragment>
    )
}

const mapState = (state) => {
    return {
        session: state.session,
        schoolList: state.schoolData.schoolData,
    }
}

const mapDispatch = (dispatch) => {
    return {
        loadSchoolDetails: (schoolId) => dispatch(loadSchoolDetails(schoolId)),
        loadSchoolData: () => dispatch(loadSchoolData()),
    }
}

export default connect(mapState, mapDispatch)(Profile);
