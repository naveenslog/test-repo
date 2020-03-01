import React from 'react';
import TableRow from '@material-ui/core/TableRow';
import TableCell from '@material-ui/core/TableCell';

export const repeatRows = (nRows, nCols, className) => {
  let rows = []
  let cols = []
  for (let i = 1; i < nRows; i++) {
    rows.push(i)
  }
  for (let i = 1; i < nCols; i++) {
    cols.push(i)
  }

  return (
    rows.map((item, keyRow) => (
      <TableRow key={keyRow} >
        {cols.map((item, keyCol) => (
          <TableCell key={keyCol} className={className} component="th" scope="row" />
        ))}
      </TableRow>
    ))
  )
}