/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

`timescale 1ns / 1ps

module FullAdder(carry_out, S, A, B, carry_in);
    input A, B, carry_in;
    output carry_out, S;
    wire S1, C1, C2;
    
    xor(S1, A, B);
    and(C1, A, B);
    xor(S, S1, carry_in);
    and(C2, S1, carry_in);
    or(carry_out, C1, C2);
    
endmodule

module Node1(horiz_carry_out, vert_carry_out, A, B, horiz_carry_in, vert_carry_in);
    input A, B, horiz_carry_in, vert_carry_in;
    output horiz_carry_out, vert_carry_out;
    wire W1;
    
    assign W1 = A & B;
    FullAdder FA1(horiz_carry_out, vert_carry_out, W1, horiz_carry_in, vert_carry_in);
endmodule

module  tt_um_array_multiplier (
    input [3:0] m, q,
    output [7:0] p
    );
    
    wire [3:0] sum0, sum1, sum2, sum3, sum4, sum5, sum6;
    wire [3:0] c0, c1, c2, c3, c4, c5, c6;
    
    Node1 node0(c0[0], sum0[0],m[0], q[0], 0, 0);
    Node1 node1(c1[0], sum1[0], m[1], q[0], c0[0], 0);
    Node1 node2(c2[0], sum2[0], m[2], q[0], c1[0], 0);
    Node1 node3(c3[0], sum3[0], m[3], q[0], c2[0], 0);
    Node1 node4(c1[1], sum1[1], m[0], q[1], 0, sum1[0]);
    Node1 node5(c2[1], sum2[1], m[1], q[1], c1[1], sum2[0]);
    Node1 node6(c3[1], sum3[1], m[2], q[1], c2[1], sum3[0]);
    Node1 node7(c4[1], sum4[1], m[3], q[1], c3[1], c3[0]);
    Node1 node8(c2[2], sum2[2], m[0], q[2], 0, sum2[1]);
    Node1 node9(c3[2], sum3[2], m[1], q[2], c2[2], sum3[1]);
    Node1 node10(c4[2], sum4[2], m[2], q[2], c3[2], sum4[1]);
    Node1 node11(c5[2], sum5[2], m[3], q[2], c4[2], c4[1]);
    Node1 node12(c3[3], sum3[3], m[0], q[3], 0, sum3[2]);
    Node1 node13(c4[3], sum4[3], m[1], q[3], c3[3], sum4[2]);
    Node1 node14(c5[3], sum5[3], m[2], q[3], c4[3], sum5[2]);
    Node1 node15(c6[3], sum6[3], m[3], q[3], c5[3], c5[2]);
    
    assign p[0] = sum0[0];
    assign p[1] = sum1[1];
    assign p[2] = sum2[2];
    assign p[3] = sum3[3];
    assign p[4] = sum4[3];
    assign p[5] = sum5[3];
    assign p[6] = sum6[3];
    assign p[7] = c6[3];
endmodule