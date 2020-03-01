import React, { useState, useEffect } from 'react';
import { connect } from 'react-redux';
import Header from './header';
import { loadSchoolDetails, loadSchoolData, loadSchoolEnq } from '../../reducers/schoolReducer';
import CssBaseline from '@material-ui/core/CssBaseline';
import Grid from '@material-ui/core/Grid';
import Container from '@material-ui/core/Container';
import { makeStyles } from '@material-ui/core/styles';
import Divider from '@material-ui/core/Divider';
import clsx from 'clsx';
import Paper from '@material-ui/core/Paper';
import Listing from '../common/listing'

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


const School = (props) => {
    const { session, loadSchoolDetails, schoolDetails, loadSchoolEnqList, schoolEnqList } = props;
    const classes = useStyles();
    const fixedHeightPaper = clsx(classes.paper, classes.fixedHeight);

    useEffect(() => {
        session && session.membership && loadSchoolDetails(session.membership.id)
        session && session.membership && loadSchoolEnqList({"schoolprofile_id": session.membership.id})
    }, [])

    return (
        <React.Fragment>
            <CssBaseline />
            <Container maxWidth="xl">
                <main>
                    <Header post={schoolDetails} />
                    {/* <Grid item xs={12} md={4} lg={3}> */}
                        {schoolEnqList&&schoolEnqList.map(item => (
                            <React.Fragment>
                                <Divider />
                                <Listing item={item} />
                            </React.Fragment>
                        ))}
                    {/* </Grid> */}
                </main>
            </Container>
        </React.Fragment>
    )
}

const mapState = (state) => {
    return {
        session: state.session,
        schoolDetails: state.schoolData.schoolDetails,
        schoolEnqList: state.schoolData.schoolEnq
    }
}

const mapDispatch = (dispatch) => {
    return {
        loadSchoolDetails: (schoolId) => dispatch(loadSchoolDetails(schoolId)),
        loadSchoolData: () => dispatch(loadSchoolData()),
        loadSchoolEnqList: (prarm) => dispatch(loadSchoolEnq(prarm))
    }
}

export default connect(mapState, mapDispatch)(School);
