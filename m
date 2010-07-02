Message-ID: <4C2DF851.5050609@domain.hid>
Date: Fri, 02 Jul 2010 16:31:45 +0200
From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
MIME-Version: 1.0
References: <1278071353-13836-1-git-send-email-wolfgang.mauerer@domain.hid>
	<1278071353-13836-8-git-send-email-wolfgang.mauerer@domain.hid>
	<4C2DF5D6.3030607@domain.hid>
In-Reply-To: <4C2DF5D6.3030607@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH (7+1)/7] posix: Add some example code for
	CLOCK_HOST_REALTIME
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Kiszka, Jan" <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Kiszka, Jan wrote:
> Wolfgang Mauerer wrote:
>> ... and for reading the contents of the hostrt data.
>>
> 
> Just realized: Please also update clocktest. Should already work with
> the new clock ID, but requires a cosmetic output patch.

easy enough -- here you go ;-) (I'll integrate this into the series)

Best, Wolfgang

diff --git a/src/testsuite/clocktest/clocktest.c
b/src/testsuite/clocktest/clocktest.c
index f0a29ba..42f3f0b 100644
--- a/src/testsuite/clocktest/clocktest.c
+++ b/src/testsuite/clocktest/clocktest.c
@@ -234,6 +234,10 @@ int main(int argc, char *argv[])
             printf("CLOCK_MONOTONIC");
             break;

+        case CLOCK_HOST_REALTIME:
+            printf("CLOCK_HOST_REALTIME");
+            break;
+
         default:
             printf("<unknown>");
             break;

