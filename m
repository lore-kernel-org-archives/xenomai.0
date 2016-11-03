MIME-Version: 1.0
From: "Florian G." <florian.r.groeger@gmail.com>
Date: Fri, 4 Nov 2016 00:55:01 +0100
Message-ID: <CAPdz0-x=sQMY-0DKYQX+PXjXM0br6eGm=Kyo_CrBPtwJndGfnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Writing into files without mode switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I'm using Xenomai 2.6.5 on a 3.8.13 kernel on an ARM 32-bit(BeagleBone
Black).
Right now we need a way to write into files without getting a mode switch.
I tried to use the rtdk.h header, but it won't work.
rt_printf works perfectly fine, but I am not able to write something in a
file. The code is compiled with gcc and the xenomai flags of the native
skin.

What do I do wrong?
Do I have to set an additional flag? Open the file in a different way?
Is there another way to achieve writing into a file without mode switch
and without writing my own RTDM?


Exemplary code:

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include <rtdk.h>


int main(int argc, char** argv){
    std::cout << "PWM test" << std::endl;

    rt_printf("rt_printf"); //working

    const std::string pwmPrefix("/sys/devices/ocp.3/pwm_test_P9_22.12/");
    FILE* fd = fopen((pwmPrefix+"period").c_str(),"w");

    rt_fprintf(fd, "10000"); //NOT working

    fclose(fd);
    std::cout << "period set" << std::endl;
    fd = fopen((pwmPrefix+"duty").c_str(),"w");

    //fprintf(fd, "1000"); working
    rt_fprintf(fd, "1000"); //NOT working

    fclose(fd);
    std::cout << "duty set" << std::endl;
    fd = fopen((pwmPrefix+"polarity").c_str(),"w");

    //fprintf(fd, "0"); working
    rt_fprintf(fd, "0"); //NOT working

    fclose(fd);
    std::cout << "polarity set" << std::endl;
    fd = fopen((pwmPrefix+"run").c_str(),"w");

    //fprintf(fd, "1"); working
    rt_fprintf(fd, "1"); //NOT working

    fclose(fd);
    std::cout << "run set" << std::endl;
    fd = fopen("test","w");

    size_t a = rt_fwrite("test", sizeof(char), 10, fd); //NOT working

    std::cout << a << std::endl;
    fclose(fd);

    return 0;
}
