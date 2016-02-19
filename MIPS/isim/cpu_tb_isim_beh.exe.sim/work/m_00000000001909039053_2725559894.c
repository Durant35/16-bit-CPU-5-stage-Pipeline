/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x16fbe694 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "D:/Xilinx/12.3/workspace/MIPS/alu.v";
static unsigned int ng1[] = {0U, 0U};
static unsigned int ng2[] = {26U, 0U};
static unsigned int ng3[] = {2U, 0U};
static unsigned int ng4[] = {3U, 0U};
static unsigned int ng5[] = {4U, 0U};
static unsigned int ng6[] = {5U, 0U};
static unsigned int ng7[] = {19U, 0U};
static unsigned int ng8[] = {20U, 0U};
static unsigned int ng9[] = {21U, 0U};
static unsigned int ng10[] = {24U, 0U};
static unsigned int ng11[] = {25U, 0U};
static unsigned int ng12[] = {22U, 0U};
static unsigned int ng13[] = {23U, 0U};
static unsigned int ng14[] = {6U, 0U};
static unsigned int ng15[] = {7U, 0U};
static unsigned int ng16[] = {8U, 0U};
static unsigned int ng17[] = {9U, 0U};
static unsigned int ng18[] = {11U, 0U};
static unsigned int ng19[] = {13U, 0U};
static unsigned int ng20[] = {12U, 0U};
static unsigned int ng21[] = {14U, 0U};
static unsigned int ng22[] = {16U, 0U};
static unsigned int ng23[] = {15U, 0U};
static unsigned int ng24[] = {17U, 0U};
static unsigned int ng25[] = {10U, 0U};
static unsigned int ng26[] = {18U, 0U};



static void Cont_59_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    unsigned int t14;
    unsigned int t15;
    char *t16;

LAB0:    t1 = (t0 + 3648U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(59, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    t2 = (t0 + 4840);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memset(t7, 0, 8);
    t8 = 65535U;
    t9 = t8;
    t10 = (t3 + 4);
    t11 = *((unsigned int *)t3);
    t8 = (t8 & t11);
    t12 = *((unsigned int *)t10);
    t9 = (t9 & t12);
    t13 = (t7 + 4);
    t14 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t14 | t8);
    t15 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t15 | t9);
    xsi_driver_vfirst_trans(t2, 0, 15);
    t16 = (t0 + 4712);
    *((int *)t16) = 1;

LAB1:    return;
}

static void Always_66_1(char *t0)
{
    char t15[8];
    char t37[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    char *t12;
    char *t13;
    int t14;
    int t16;
    int t17;
    int t18;
    int t19;
    int t20;
    char *t21;
    int t22;
    char *t23;
    int t24;
    char *t25;
    int t26;
    char *t27;
    int t28;
    char *t29;
    int t30;
    char *t31;
    int t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;

LAB0:    t1 = (t0 + 3896U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(66, ng0);
    t2 = (t0 + 4728);
    *((int *)t2) = 1;
    t3 = (t0 + 3928);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(67, ng0);

LAB5:    xsi_set_current_line(68, ng0);
    t4 = (t0 + 1048U);
    t5 = *((char **)t4);
    t4 = (t5 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB6;

LAB7:    xsi_set_current_line(70, ng0);
    t2 = (t0 + 1208U);
    t3 = *((char **)t2);

LAB9:    t2 = ((char*)((ng2)));
    t14 = xsi_vlog_unsigned_case_compare(t3, 5, t2, 5);
    if (t14 == 1)
        goto LAB10;

LAB11:    t2 = ((char*)((ng3)));
    t14 = xsi_vlog_unsigned_case_compare(t3, 5, t2, 5);
    if (t14 == 1)
        goto LAB12;

LAB13:    t4 = ((char*)((ng4)));
    t16 = xsi_vlog_unsigned_case_compare(t3, 5, t4, 5);
    if (t16 == 1)
        goto LAB14;

LAB15:    t5 = ((char*)((ng5)));
    t17 = xsi_vlog_unsigned_case_compare(t3, 5, t5, 5);
    if (t17 == 1)
        goto LAB16;

LAB17:    t11 = ((char*)((ng6)));
    t18 = xsi_vlog_unsigned_case_compare(t3, 5, t11, 5);
    if (t18 == 1)
        goto LAB18;

LAB19:    t12 = ((char*)((ng7)));
    t19 = xsi_vlog_unsigned_case_compare(t3, 5, t12, 5);
    if (t19 == 1)
        goto LAB20;

LAB21:    t13 = ((char*)((ng8)));
    t20 = xsi_vlog_unsigned_case_compare(t3, 5, t13, 5);
    if (t20 == 1)
        goto LAB22;

LAB23:    t21 = ((char*)((ng9)));
    t22 = xsi_vlog_unsigned_case_compare(t3, 5, t21, 5);
    if (t22 == 1)
        goto LAB24;

LAB25:    t23 = ((char*)((ng10)));
    t24 = xsi_vlog_unsigned_case_compare(t3, 5, t23, 5);
    if (t24 == 1)
        goto LAB26;

LAB27:    t25 = ((char*)((ng11)));
    t26 = xsi_vlog_unsigned_case_compare(t3, 5, t25, 5);
    if (t26 == 1)
        goto LAB28;

LAB29:    t27 = ((char*)((ng12)));
    t28 = xsi_vlog_unsigned_case_compare(t3, 5, t27, 5);
    if (t28 == 1)
        goto LAB30;

LAB31:    t29 = ((char*)((ng13)));
    t30 = xsi_vlog_unsigned_case_compare(t3, 5, t29, 5);
    if (t30 == 1)
        goto LAB32;

LAB33:    t31 = ((char*)((ng14)));
    t32 = xsi_vlog_unsigned_case_compare(t3, 5, t31, 5);
    if (t32 == 1)
        goto LAB34;

LAB35:    t2 = ((char*)((ng15)));
    t14 = xsi_vlog_unsigned_case_compare(t3, 5, t2, 5);
    if (t14 == 1)
        goto LAB36;

LAB37:    t2 = ((char*)((ng16)));
    t14 = xsi_vlog_unsigned_case_compare(t3, 5, t2, 5);
    if (t14 == 1)
        goto LAB38;

LAB39:    t4 = ((char*)((ng17)));
    t16 = xsi_vlog_unsigned_case_compare(t3, 5, t4, 5);
    if (t16 == 1)
        goto LAB40;

LAB41:    t2 = ((char*)((ng18)));
    t14 = xsi_vlog_unsigned_case_compare(t3, 5, t2, 5);
    if (t14 == 1)
        goto LAB42;

LAB43:    t2 = ((char*)((ng19)));
    t14 = xsi_vlog_unsigned_case_compare(t3, 5, t2, 5);
    if (t14 == 1)
        goto LAB44;

LAB45:    t2 = ((char*)((ng20)));
    t14 = xsi_vlog_unsigned_case_compare(t3, 5, t2, 5);
    if (t14 == 1)
        goto LAB46;

LAB47:    t2 = ((char*)((ng21)));
    t14 = xsi_vlog_unsigned_case_compare(t3, 5, t2, 5);
    if (t14 == 1)
        goto LAB48;

LAB49:    t2 = ((char*)((ng22)));
    t14 = xsi_vlog_unsigned_case_compare(t3, 5, t2, 5);
    if (t14 == 1)
        goto LAB50;

LAB51:    t2 = ((char*)((ng23)));
    t14 = xsi_vlog_unsigned_case_compare(t3, 5, t2, 5);
    if (t14 == 1)
        goto LAB52;

LAB53:    t2 = ((char*)((ng24)));
    t14 = xsi_vlog_unsigned_case_compare(t3, 5, t2, 5);
    if (t14 == 1)
        goto LAB54;

LAB55:    t2 = ((char*)((ng25)));
    t14 = xsi_vlog_unsigned_case_compare(t3, 5, t2, 5);
    if (t14 == 1)
        goto LAB56;

LAB57:    t2 = ((char*)((ng26)));
    t14 = xsi_vlog_unsigned_case_compare(t3, 5, t2, 5);
    if (t14 == 1)
        goto LAB58;

LAB59:
LAB60:
LAB8:    goto LAB2;

LAB6:    xsi_set_current_line(68, ng0);
    t11 = ((char*)((ng1)));
    t12 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, 0, 16, 0LL);
    t13 = (t0 + 2728);
    xsi_vlogvar_wait_assign_value(t13, t11, 16, 0, 1, 0LL);
    goto LAB8;

LAB10:    xsi_set_current_line(76, ng0);
    t4 = (t0 + 1368U);
    t5 = *((char **)t4);
    t4 = (t0 + 1528U);
    t11 = *((char **)t4);
    memset(t15, 0, 8);
    xsi_vlog_unsigned_add(t15, 17, t5, 16, t11, 16);
    t4 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t4, t15, 0, 0, 16, 0LL);
    t12 = (t0 + 2728);
    xsi_vlogvar_wait_assign_value(t12, t15, 16, 0, 1, 0LL);
    goto LAB60;

LAB12:    goto LAB10;

LAB14:    goto LAB10;

LAB16:    goto LAB10;

LAB18:    goto LAB10;

LAB20:    goto LAB10;

LAB22:    goto LAB10;

LAB24:    goto LAB10;

LAB26:    goto LAB10;

LAB28:    goto LAB10;

LAB30:    goto LAB10;

LAB32:    goto LAB10;

LAB34:    xsi_set_current_line(77, ng0);
    t33 = (t0 + 1368U);
    t34 = *((char **)t33);
    t33 = (t0 + 1528U);
    t35 = *((char **)t33);
    memset(t15, 0, 8);
    xsi_vlog_unsigned_add(t15, 17, t34, 16, t35, 16);
    t33 = (t0 + 1688U);
    t36 = *((char **)t33);
    memset(t37, 0, 8);
    xsi_vlog_unsigned_add(t37, 17, t15, 17, t36, 1);
    t33 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t33, t37, 0, 0, 16, 0LL);
    t38 = (t0 + 2728);
    xsi_vlogvar_wait_assign_value(t38, t37, 16, 0, 1, 0LL);
    goto LAB60;

LAB36:    xsi_set_current_line(79, ng0);
    t4 = (t0 + 1368U);
    t5 = *((char **)t4);
    t4 = (t0 + 1528U);
    t11 = *((char **)t4);
    memset(t15, 0, 8);
    xsi_vlog_unsigned_minus(t15, 17, t5, 16, t11, 16);
    t4 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t4, t15, 0, 0, 16, 0LL);
    t12 = (t0 + 2728);
    xsi_vlogvar_wait_assign_value(t12, t15, 16, 0, 1, 0LL);
    goto LAB60;

LAB38:    goto LAB36;

LAB40:    xsi_set_current_line(80, ng0);
    t5 = (t0 + 1368U);
    t11 = *((char **)t5);
    t5 = (t0 + 1528U);
    t12 = *((char **)t5);
    memset(t15, 0, 8);
    xsi_vlog_unsigned_minus(t15, 17, t11, 16, t12, 16);
    t5 = (t0 + 1688U);
    t13 = *((char **)t5);
    memset(t37, 0, 8);
    xsi_vlog_unsigned_minus(t37, 17, t15, 17, t13, 1);
    t5 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t5, t37, 0, 0, 16, 0LL);
    t21 = (t0 + 2728);
    xsi_vlogvar_wait_assign_value(t21, t37, 16, 0, 1, 0LL);
    goto LAB60;

LAB42:    xsi_set_current_line(81, ng0);
    t4 = (t0 + 1368U);
    t5 = *((char **)t4);
    t4 = (t0 + 1528U);
    t11 = *((char **)t4);
    t6 = *((unsigned int *)t5);
    t7 = *((unsigned int *)t11);
    t8 = (t6 & t7);
    *((unsigned int *)t15) = t8;
    t4 = (t5 + 4);
    t12 = (t11 + 4);
    t13 = (t15 + 4);
    t9 = *((unsigned int *)t4);
    t10 = *((unsigned int *)t12);
    t39 = (t9 | t10);
    *((unsigned int *)t13) = t39;
    t40 = *((unsigned int *)t13);
    t41 = (t40 != 0);
    if (t41 == 1)
        goto LAB61;

LAB62:
LAB63:    t25 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t25, t15, 0, 0, 16, 0LL);
    t27 = (t0 + 2728);
    xsi_vlogvar_wait_assign_value(t27, t15, 16, 0, 1, 0LL);
    goto LAB60;

LAB44:    xsi_set_current_line(82, ng0);
    t4 = (t0 + 1368U);
    t5 = *((char **)t4);
    t4 = (t0 + 1528U);
    t11 = *((char **)t4);
    t6 = *((unsigned int *)t5);
    t7 = *((unsigned int *)t11);
    t8 = (t6 ^ t7);
    *((unsigned int *)t15) = t8;
    t4 = (t5 + 4);
    t12 = (t11 + 4);
    t13 = (t15 + 4);
    t9 = *((unsigned int *)t4);
    t10 = *((unsigned int *)t12);
    t39 = (t9 | t10);
    *((unsigned int *)t13) = t39;
    t40 = *((unsigned int *)t13);
    t41 = (t40 != 0);
    if (t41 == 1)
        goto LAB64;

LAB65:
LAB66:    t21 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t21, t15, 0, 0, 16, 0LL);
    t23 = (t0 + 2728);
    xsi_vlogvar_wait_assign_value(t23, t15, 16, 0, 1, 0LL);
    goto LAB60;

LAB46:    xsi_set_current_line(83, ng0);
    t4 = (t0 + 1368U);
    t5 = *((char **)t4);
    t4 = (t0 + 1528U);
    t11 = *((char **)t4);
    t6 = *((unsigned int *)t5);
    t7 = *((unsigned int *)t11);
    t8 = (t6 | t7);
    *((unsigned int *)t15) = t8;
    t4 = (t5 + 4);
    t12 = (t11 + 4);
    t13 = (t15 + 4);
    t9 = *((unsigned int *)t4);
    t10 = *((unsigned int *)t12);
    t39 = (t9 | t10);
    *((unsigned int *)t13) = t39;
    t40 = *((unsigned int *)t13);
    t41 = (t40 != 0);
    if (t41 == 1)
        goto LAB67;

LAB68:
LAB69:    t25 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t25, t15, 0, 0, 16, 0LL);
    t27 = (t0 + 2728);
    xsi_vlogvar_wait_assign_value(t27, t15, 16, 0, 1, 0LL);
    goto LAB60;

LAB48:    xsi_set_current_line(84, ng0);
    t4 = (t0 + 1368U);
    t5 = *((char **)t4);
    t4 = (t0 + 1528U);
    t11 = *((char **)t4);
    memset(t15, 0, 8);
    xsi_vlog_unsigned_lshift(t15, 17, t5, 16, t11, 16);
    t4 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t4, t15, 0, 0, 16, 0LL);
    t12 = (t0 + 2728);
    xsi_vlogvar_wait_assign_value(t12, t15, 16, 0, 1, 0LL);
    goto LAB60;

LAB50:    xsi_set_current_line(85, ng0);
    t4 = (t0 + 2168U);
    t5 = *((char **)t4);
    t4 = (t0 + 1528U);
    t11 = *((char **)t4);
    memset(t15, 0, 8);
    xsi_vlog_signed_arith_lshift(t15, 17, t5, 16, t11, 16);
    t4 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t4, t15, 0, 0, 16, 0LL);
    t12 = (t0 + 2728);
    xsi_vlogvar_wait_assign_value(t12, t15, 16, 0, 1, 0LL);
    goto LAB60;

LAB52:    xsi_set_current_line(86, ng0);
    t4 = (t0 + 1368U);
    t5 = *((char **)t4);
    t4 = (t0 + 1528U);
    t11 = *((char **)t4);
    memset(t15, 0, 8);
    xsi_vlog_unsigned_rshift(t15, 17, t5, 16, t11, 16);
    t4 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t4, t15, 0, 0, 16, 0LL);
    t12 = (t0 + 2728);
    xsi_vlogvar_wait_assign_value(t12, t15, 16, 0, 1, 0LL);
    goto LAB60;

LAB54:    xsi_set_current_line(87, ng0);
    t4 = (t0 + 2168U);
    t5 = *((char **)t4);
    t4 = (t0 + 1528U);
    t11 = *((char **)t4);
    memset(t15, 0, 8);
    xsi_vlog_signed_arith_rshift(t15, 17, t5, 16, t11, 16);
    t4 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t4, t15, 0, 0, 16, 0LL);
    t12 = (t0 + 2728);
    xsi_vlogvar_wait_assign_value(t12, t15, 16, 0, 1, 0LL);
    goto LAB60;

LAB56:    xsi_set_current_line(88, ng0);
    t4 = (t0 + 1368U);
    t5 = *((char **)t4);
    t4 = (t0 + 1528U);
    t11 = *((char **)t4);
    memset(t15, 0, 8);
    xsi_vlog_unsigned_minus(t15, 17, t5, 16, t11, 16);
    t4 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t4, t15, 0, 0, 16, 0LL);
    t12 = (t0 + 2728);
    xsi_vlogvar_wait_assign_value(t12, t15, 16, 0, 1, 0LL);
    goto LAB60;

LAB58:    xsi_set_current_line(89, ng0);
    t4 = (t0 + 1528U);
    t5 = *((char **)t4);
    memcpy(t15, t5, 8);
    t4 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t4, t15, 0, 0, 16, 0LL);
    t11 = (t0 + 2728);
    xsi_vlogvar_wait_assign_value(t11, t15, 16, 0, 1, 0LL);
    goto LAB60;

LAB61:    t42 = *((unsigned int *)t15);
    t43 = *((unsigned int *)t13);
    *((unsigned int *)t15) = (t42 | t43);
    t21 = (t5 + 4);
    t23 = (t11 + 4);
    t44 = *((unsigned int *)t5);
    t45 = (~(t44));
    t46 = *((unsigned int *)t21);
    t47 = (~(t46));
    t48 = *((unsigned int *)t11);
    t49 = (~(t48));
    t50 = *((unsigned int *)t23);
    t51 = (~(t50));
    t16 = (t45 & t47);
    t17 = (t49 & t51);
    t52 = (~(t16));
    t53 = (~(t17));
    t54 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t54 & t52);
    t55 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t55 & t53);
    t56 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t56 & t52);
    t57 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t57 & t53);
    goto LAB63;

LAB64:    t42 = *((unsigned int *)t15);
    t43 = *((unsigned int *)t13);
    *((unsigned int *)t15) = (t42 | t43);
    goto LAB66;

LAB67:    t42 = *((unsigned int *)t15);
    t43 = *((unsigned int *)t13);
    *((unsigned int *)t15) = (t42 | t43);
    t21 = (t5 + 4);
    t23 = (t11 + 4);
    t44 = *((unsigned int *)t21);
    t45 = (~(t44));
    t46 = *((unsigned int *)t5);
    t16 = (t46 & t45);
    t47 = *((unsigned int *)t23);
    t48 = (~(t47));
    t49 = *((unsigned int *)t11);
    t17 = (t49 & t48);
    t50 = (~(t16));
    t51 = (~(t17));
    t52 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t52 & t50);
    t53 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t53 & t51);
    goto LAB69;

}

static void Cont_94_2(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;

LAB0:    t1 = (t0 + 4144U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(94, ng0);
    t2 = (t0 + 2568);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 4904);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memset(t9, 0, 8);
    t10 = 65535U;
    t11 = t10;
    t12 = (t4 + 4);
    t13 = *((unsigned int *)t4);
    t10 = (t10 & t13);
    t14 = *((unsigned int *)t12);
    t11 = (t11 & t14);
    t15 = (t9 + 4);
    t16 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t16 | t10);
    t17 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t17 | t11);
    xsi_driver_vfirst_trans(t5, 0, 15);
    t18 = (t0 + 4744);
    *((int *)t18) = 1;

LAB1:    return;
}

static void Cont_95_3(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;

LAB0:    t1 = (t0 + 4392U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(95, ng0);
    t2 = (t0 + 2728);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 4968);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memset(t9, 0, 8);
    t10 = 1U;
    t11 = t10;
    t12 = (t4 + 4);
    t13 = *((unsigned int *)t4);
    t10 = (t10 & t13);
    t14 = *((unsigned int *)t12);
    t11 = (t11 & t14);
    t15 = (t9 + 4);
    t16 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t16 | t10);
    t17 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t17 | t11);
    xsi_driver_vfirst_trans(t5, 0, 0);
    t18 = (t0 + 4760);
    *((int *)t18) = 1;

LAB1:    return;
}


extern void work_m_00000000001909039053_2725559894_init()
{
	static char *pe[] = {(void *)Cont_59_0,(void *)Always_66_1,(void *)Cont_94_2,(void *)Cont_95_3};
	xsi_register_didat("work_m_00000000001909039053_2725559894", "isim/cpu_tb_isim_beh.exe.sim/work/m_00000000001909039053_2725559894.didat");
	xsi_register_executes(pe);
}
