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

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000001909039053_2725559894_init();
    work_m_00000000001900668371_3877310806_init();
    work_m_00000000000300921111_0610666722_init();
    work_m_00000000000131512709_3258266500_init();
    work_m_00000000001102671466_0924832676_init();
    work_m_00000000000693806535_1912994691_init();
    work_m_00000000002013452923_2073120511_init();


    xsi_register_tops("work_m_00000000000693806535_1912994691");
    xsi_register_tops("work_m_00000000002013452923_2073120511");


    return xsi_run_simulation(argc, argv);

}
