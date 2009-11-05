MIME-Version: 1.0
Date: Thu, 5 Nov 2009 07:20:21 -0200
Message-ID: <985eb86f0911050120l3a989588ida812a9394659a78@domain.hid>
From: tarek ben ali <tarekbenali@domain.hid>
Content-Type: multipart/alternative; boundary=001636026f86888e6c04779c3c9f
Subject: [Xenomai-core] setting priority
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>, xenomai@xenomai.org

--001636026f86888e6c04779c3c9f
Content-Type: text/plain; charset=ISO-8859-1

I'm trying to set priority to a specified process on including its PID,the
code below is running BUT after allocating priority and policy  the output
of "top" commande seems not changing(the priority of the process specified
is still the same).Is there any explanation please?


#include <sched.h>
#include <errno.h>
#include <unistd.h>
#include <stdio.h>
#include "posixtest.h"

struct unique {
        int value;
        char *name;
} sym[] = {

        {
                SCHED_FIFO, "SCHED_FIFO"
        },
        {
                SCHED_RR, "SCHED_RR"
        },
//#if defined(_POSIX_SPORADIC_SERVER) ||
defined(_POSIX_THREAD_SPORADIC_SERVER)
//        {
//                SCHED_SPORADIC,"SCHED_SPORADIC"
//        },
//#endif
        {
                SCHED_OTHER, "SCHED_OTHER"
        },
        {
                0, 0
        }
};

int main(int argc, char **argv)
{
        int tmp, policy, priority,pid, result = PTS_PASS,old_priority,
old_policy;
        struct sched_param param;
        struct unique *tst;


        printf("Set the PID of the process you want to modifie its priority:
");
        scanf("%d",&pid);
        if(sched_getparam(pid, &param) == -1) {
                perror("An error occurs when calling sched_getparam()");
                return PTS_UNRESOLVED;
        }
        old_priority = param.sched_priority;
        old_policy = sched_getscheduler(pid);
        printf("The current priority set is %d and the the current policy is
%d \n",old_priority,old_policy);

printf("******************************************************************\n
");
        if(old_policy == -1) {
                perror("An error occurs when calling sched_getscheduler()");
                return PTS_UNRESOLVED;
        }

        tst = sym;
        while (tst->name) {
                fflush(stderr);
                printf("Policy: %s\n", tst->name);
                fflush(stdout);

                policy = tst->value;
                //priority = ( sched_get_priority_min(policy) +
                //             sched_get_priority_max(policy) ) / 2;
                priority=1;
                param.sched_priority = priority;

                tmp = sched_setscheduler(pid, policy, &param);

                if(tmp == -1 || errno != 0) {
                        if(errno == EPERM){
                                printf("  The process do not have permission
to change its own scheduler\n  Try to run this test as root.\n");
                        } else {
                                printf("  Error calling sched_setscheduler()
for %s policy\n", tst->name);
                        }
                        if(result != PTS_FAIL) result = PTS_UNRESOLVED;
                        tst++;
                        continue;
                }

                if(sched_getparam(pid, &param) != 0) {
                        perror("Error calling sched_getparam()");
                        return PTS_UNRESOLVED;
                }

                if(policy != sched_getscheduler(pid)){
                        printf("  sched_setscheduler() does not set the
policy to %s.\n", tst->name);
                        result = PTS_FAIL;
                }
                if(priority != param.sched_priority) {
                        printf("  sched_setscheduler() does not set the
right param for %s policy.\n", tst->name);
                        result = PTS_FAIL;
                }

                tst++;
        }

        if(result == PTS_PASS)
                printf("Test PASSED\n");
        return result;
}

--001636026f86888e6c04779c3c9f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGJyPkkmIzM5O20gdHJ5aW5nIHRvIHNldCBwcmlvcml0eSB0byBhIHNw
ZWNpZmllZCBwcm9jZXNzIG9uIGluY2x1ZGluZyBpdHMgUElELHRoZSBjb2RlIGJlbG93IGlzIHJ1
bm5pbmcgQlVUIGFmdGVyIGFsbG9jYXRpbmcgcHJpb3JpdHkgYW5kIHBvbGljeaAgdGhlIG91dHB1
dCBvZiAmcXVvdDt0b3AmcXVvdDsgY29tbWFuZGUgc2VlbXMgbm90IGNoYW5naW5nKHRoZSBwcmlv
cml0eSBvZiB0aGUgcHJvY2VzcyBzcGVjaWZpZWQgaXMgc3RpbGwgdGhlIHNhbWUpLklzIHRoZXJl
IGFueSBleHBsYW5hdGlvbiBwbGVhc2U/PGJyPgo8YnI+PGJyPiNpbmNsdWRlICZsdDtzY2hlZC5o
Jmd0OyA8YnI+I2luY2x1ZGUgJmx0O2Vycm5vLmgmZ3Q7PGJyPiNpbmNsdWRlICZsdDt1bmlzdGQu
aCZndDs8YnI+I2luY2x1ZGUgJmx0O3N0ZGlvLmgmZ3Q7PGJyPiNpbmNsdWRlICZxdW90O3Bvc2l4
dGVzdC5oJnF1b3Q7PGJyPjxicj5zdHJ1Y3QgdW5pcXVlIHs8YnI+oKCgoKCgoCBpbnQgdmFsdWU7
PGJyPqCgoKCgoKAgY2hhciAqbmFtZTs8YnI+Cn0gc3ltW10gPSB7PGJyPjxicj6goKCgoKCgIHs8
YnI+oKCgoKCgoKCgoKCgoKCgIFNDSEVEX0ZJRk8sICZxdW90O1NDSEVEX0ZJRk8mcXVvdDs8YnI+
oKCgoKCgoCB9LDxicj6goKCgoKCgIHs8YnI+oKCgoKCgoKCgoKCgoKCgIFNDSEVEX1JSLCAmcXVv
dDtTQ0hFRF9SUiZxdW90Ozxicj6goKCgoKCgIH0sPGJyPi8vI2lmIGRlZmluZWQoX1BPU0lYX1NQ
T1JBRElDX1NFUlZFUikgfHwgZGVmaW5lZChfUE9TSVhfVEhSRUFEX1NQT1JBRElDX1NFUlZFUik8
YnI+Ci8voKCgoKCgoCB7PGJyPi8voKCgoKCgoKCgoKCgoKCgIFNDSEVEX1NQT1JBRElDLCZxdW90
O1NDSEVEX1NQT1JBRElDJnF1b3Q7PGJyPi8voKCgoKCgoCB9LDxicj4vLyNlbmRpZjxicj6goKCg
oKCgIHs8YnI+oKCgoKCgoKCgoKCgoKCgIFNDSEVEX09USEVSLCAmcXVvdDtTQ0hFRF9PVEhFUiZx
dW90Ozxicj6goKCgoKCgIH0sPGJyPqCgoKCgoKAgezxicj6goKCgoKCgoKCgoKCgoKAgMCwgMDxi
cj4KoKCgoKCgoCB9PGJyPn07PGJyPjxicj5pbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3Yp
PGJyPns8YnI+oKCgoKCgoCBpbnQgdG1wLCBwb2xpY3ksIHByaW9yaXR5LHBpZCwgcmVzdWx0ID0g
UFRTX1BBU1Msb2xkX3ByaW9yaXR5LCBvbGRfcG9saWN5Ozxicj6goKCgoKCgIHN0cnVjdCBzY2hl
ZF9wYXJhbSBwYXJhbTs8YnI+oKCgoKCgoCBzdHJ1Y3QgdW5pcXVlICp0c3Q7PGJyPqCgoKCgoKAg
PGJyPgo8YnI+oKCgoKCgoCBwcmludGYoJnF1b3Q7U2V0IHRoZSBQSUQgb2YgdGhlIHByb2Nlc3Mg
eW91IHdhbnQgdG8gbW9kaWZpZSBpdHMgcHJpb3JpdHk6ICZxdW90Oyk7PGJyPqCgoKCgoKAgc2Nh
bmYoJnF1b3Q7JWQmcXVvdDssJmFtcDtwaWQpOzxicj6goKCgoKCgIGlmKHNjaGVkX2dldHBhcmFt
KHBpZCwgJmFtcDtwYXJhbSkgPT0gLTEpIHs8YnI+oKCgoKCgoKCgoKCgoKCgIHBlcnJvcigmcXVv
dDtBbiBlcnJvciBvY2N1cnMgd2hlbiBjYWxsaW5nIHNjaGVkX2dldHBhcmFtKCkmcXVvdDspOzxi
cj4KoKCgoKCgoKCgoKCgoKCgIHJldHVybiBQVFNfVU5SRVNPTFZFRDs8YnI+oKCgoKCgoCB9PGJy
PqCgoKCgoKAgb2xkX3ByaW9yaXR5ID0gcGFyYW0uc2NoZWRfcHJpb3JpdHk7PGJyPqCgoKCgoKAg
b2xkX3BvbGljeSA9IHNjaGVkX2dldHNjaGVkdWxlcihwaWQpOzxicj6goKCgoKCgIHByaW50Zigm
cXVvdDtUaGUgY3VycmVudCBwcmlvcml0eSBzZXQgaXMgJWQgYW5kIHRoZSB0aGUgY3VycmVudCBw
b2xpY3kgaXMgJWQgXG4mcXVvdDssb2xkX3ByaW9yaXR5LG9sZF9wb2xpY3kpOzxicj4KoKCgoKCg
oCBwcmludGYoJnF1b3Q7KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqXG4gJnF1b3Q7KTs8YnI+oKCgoKCgoCBpZihvbGRfcG9s
aWN5ID09IC0xKSB7PGJyPqCgoKCgoKCgoKCgoKCgoCBwZXJyb3IoJnF1b3Q7QW4gZXJyb3Igb2Nj
dXJzIHdoZW4gY2FsbGluZyBzY2hlZF9nZXRzY2hlZHVsZXIoKSZxdW90Oyk7PGJyPgqgoKCgoKCg
oKCgoKCgoKAgcmV0dXJuIFBUU19VTlJFU09MVkVEOzxicj6goKCgoKCgIH08YnI+PGJyPqCgoKCg
oKAgdHN0ID0gc3ltOzxicj6goKCgoKCgIHdoaWxlICh0c3QtJmd0O25hbWUpIHs8YnI+oKCgoKCg
oKCgoKCgoKCgIGZmbHVzaChzdGRlcnIpOzxicj6goKCgoKCgoKCgoKCgoKAgcHJpbnRmKCZxdW90
O1BvbGljeTogJXNcbiZxdW90OywgdHN0LSZndDtuYW1lKTs8YnI+oKCgoKCgoKCgoKCgoKCgIGZm
bHVzaChzdGRvdXQpOzxicj4KPGJyPqCgoKCgoKCgoKCgoKCgoCBwb2xpY3kgPSB0c3QtJmd0O3Zh
bHVlOzxicj6goKCgoKCgoKCgoKCgoKAgLy9wcmlvcml0eSA9ICggc2NoZWRfZ2V0X3ByaW9yaXR5
X21pbihwb2xpY3kpICs8YnI+oKCgoKCgoKCgoKCgoKCgIC8voKCgoKCgoKCgoKCgIHNjaGVkX2dl
dF9wcmlvcml0eV9tYXgocG9saWN5KSApIC8gMjs8YnI+oKCgoKCgoKCgoKCgoKCgIHByaW9yaXR5
PTE7PGJyPqCgoKCgoKCgoKCgoKCgoCBwYXJhbS5zY2hlZF9wcmlvcml0eSA9IHByaW9yaXR5Ozxi
cj4KPGJyPqCgoKCgoKCgoKCgoKCgoCB0bXAgPSBzY2hlZF9zZXRzY2hlZHVsZXIocGlkLCBwb2xp
Y3ksICZhbXA7cGFyYW0pOzxicj48YnI+oKCgoKCgoKCgoKCgoKCgIGlmKHRtcCA9PSAtMSB8fCBl
cnJubyAhPSAwKSB7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIGlmKGVycm5vID09IEVQRVJN
KXs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCBwcmludGYoJnF1b3Q7oCBUaGUg
cHJvY2VzcyBkbyBub3QgaGF2ZSBwZXJtaXNzaW9uIHRvIGNoYW5nZSBpdHMgb3duIHNjaGVkdWxl
clxuoCBUcnkgdG8gcnVuIHRoaXMgdGVzdCBhcyByb290LlxuJnF1b3Q7KTs8YnI+CqCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgIH0gZWxzZSB7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKAgcHJpbnRmKCZxdW90O6AgRXJyb3IgY2FsbGluZyBzY2hlZF9zZXRzY2hlZHVsZXIoKSBmb3Ig
JXMgcG9saWN5XG4mcXVvdDssIHRzdC0mZ3Q7bmFtZSk7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgIH08YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgaWYocmVzdWx0ICE9IFBUU19GQUlMKSBy
ZXN1bHQgPSBQVFNfVU5SRVNPTFZFRDs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIHRzdCsr
Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoCBjb250aW51ZTs8YnI+oKCgoKCgoKCgoKCgoKCg
IH08YnI+PGJyPqCgoKCgoKCgoKCgoKCgoCBpZihzY2hlZF9nZXRwYXJhbShwaWQsICZhbXA7cGFy
YW0pICE9IDApIHs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgcGVycm9yKCZxdW90O0Vycm9y
IGNhbGxpbmcgc2NoZWRfZ2V0cGFyYW0oKSZxdW90Oyk7PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoCByZXR1cm4gUFRTX1VOUkVTT0xWRUQ7PGJyPqCgoKCgoKCgoKCgoKCgoCB9PGJyPjxicj6g
oKCgoKCgoKCgoKCgoKAgaWYocG9saWN5ICE9IHNjaGVkX2dldHNjaGVkdWxlcihwaWQpKXs8YnI+
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgcHJpbnRmKCZxdW90O6Agc2NoZWRfc2V0c2NoZWR1bGVy
KCkgZG9lcyBub3Qgc2V0IHRoZSBwb2xpY3kgdG8gJXMuXG4mcXVvdDssIHRzdC0mZ3Q7bmFtZSk7
PGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCByZXN1bHQgPSBQVFNfRkFJTDs8YnI+oKCgoKCg
oKCgoKCgoKCgIH08YnI+oKCgoKCgoKCgoKCgoKCgIGlmKHByaW9yaXR5ICE9IHBhcmFtLnNjaGVk
X3ByaW9yaXR5KSB7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIHByaW50ZigmcXVvdDugIHNj
aGVkX3NldHNjaGVkdWxlcigpIGRvZXMgbm90IHNldCB0aGUgcmlnaHQgcGFyYW0gZm9yICVzIHBv
bGljeS5cbiZxdW90OywgdHN0LSZndDtuYW1lKTs8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
IHJlc3VsdCA9IFBUU19GQUlMOzxicj6goKCgoKCgoKCgoKCgoKAgfTxicj48YnI+oKCgoKCgoKCg
oKCgoKCgIHRzdCsrOzxicj6goKCgoKCgIH08YnI+PGJyPqCgoKCgoKAgaWYocmVzdWx0ID09IFBU
U19QQVNTKTxicj6goKCgoKCgoKCgoKCgoKAgcHJpbnRmKCZxdW90O1Rlc3QgUEFTU0VEXG4mcXVv
dDspOzxicj6goKCgoKCgIHJldHVybiByZXN1bHQ7PGJyPgp9PGJyPjxicj48L2Rpdj4K
--001636026f86888e6c04779c3c9f--

