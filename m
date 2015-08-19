Date: Wed, 19 Aug 2015 16:29:13 +0000 (UTC)
From: Frederik Bayart <frederik_bayart@yahoo.co.uk>
Message-ID: <466299436.7725534.1440001753062.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <55D36A9E.6030809@xenomai.org>
References: <55D36A9E.6030809@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xeno 3-rc7 : rtcanconfig fails to set baudrate
Reply-To: Frederik Bayart <frederik_bayart@yahoo.co.uk>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

>On Tuesday, 18 August 2015, 19:25, Philippe Gerum <rpm@xenomai.org> wrote:
>> On 08/18/2015 06:26 PM, Frederik Bayart wrote:
>
>> I have build xeno-3.0.rc7 with kernel 3.18.12.
>> I have a PEAK-PCIe CAN card in my system.
>> Drivers are loaded and rtcan0 en rtcan1 are created in /proc/rtcan.
>>
>> However, I'm not able to set the baudrate when I'm execute 'rtcanconfig rtcan0 -v -b 1000000 start'
>> By adding debug statements in rtcanconfig, I found that ioctl(can_fd, SIOCSCANBAUDRATE, &u.ifr); fails,
>> errno gives : SIOCSCANBAUDRATE(errno=19): No such device
>> Below the output of rtcan0/info and xeno-config --info
>> Any suggestions ?
>
>This error is documented, I would check ->ifr_name in the request block:
>
>http://www.xenomai.org/documentation/xenomai-3/html/xeno3prm/group__rtdm__can.html#ga7c070037c218b40de849ebf4d299f977
>
>-- 
>Philippe.


The problem was that the interface name was overwritten by the baudrate. The problem is caused by use of

union {
struct ifreq ifr;
struct can_bittime bittime;
can_baudrate_t baudrate;
can_ctrlmode_t ctrlmode;
can_mode_t mode;
} u;

I think the intention was to put struct ifreq.ifr_ifru in the union. But I think the union above doesn't work because struct ifreq has first member ifr_ifrn

struct ifreq {
#define IFHWADDRLEN	6
union
{
char	ifrn_name[IFNAMSIZ];		/* if name, e.g. "en0" */
} ifr_ifrn;

union {
...snip...
} ifr_ifru;
};

If I revert the union, the problem is solved. Diff below.

Frederik

--- rtcanconfig.c.old	2015-08-19 17:57:45.790326526 +0200
+++ rtcanconfig.c.new	2015-08-19 18:00:15.010330204 +0200
@@ -88,16 +88,10 @@
int     new_ctrlmode = 0, set_ctrlmode = 0;
int     verbose = 0;
int     bittime_count = 0, bittime_data[6];
+    struct ifreq ifr;
can_baudrate_t *baudrate;
can_ctrlmode_t *ctrlmode;
can_mode_t *mode;
-    union {
-      struct ifreq ifr;
-      struct can_bittime bittime;
-      can_baudrate_t baudrate;
-      can_ctrlmode_t ctrlmode;
-      can_mode_t mode;
-    } u;
struct can_bittime *bittime;
int opt, ret;
char* ptr;
@@ -169,7 +163,7 @@
}

strncpy(ifname, argv[optind], IFNAMSIZ);
-    strncpy(u.ifr.ifr_name, ifname, IFNAMSIZ);
+    strncpy(ifr.ifr_name, ifname, IFNAMSIZ);

if (optind == argc - 2) {   /* Get mode setting */
new_mode = string_to_mode(argv[optind + 1]);
@@ -187,7 +181,7 @@
return can_fd;
}

-    ret = ioctl(can_fd, SIOCGIFINDEX, &u.ifr);
+    ret = ioctl(can_fd, SIOCGIFINDEX, &ifr);
if (ret) {
fprintf(stderr,"Can't get interface index for %s, code = %d\n", ifname, ret);
return ret;
@@ -197,16 +191,15 @@
if (new_baudrate != -1) {
if (verbose)
printf("baudrate: %d\n", new_baudrate);
-	baudrate = &u.baudrate;
+	baudrate = (can_baudrate_t *)&ifr.ifr_ifru;
*baudrate = new_baudrate;
-	ret = ioctl(can_fd, SIOCSCANBAUDRATE, &u.ifr);
+	ret = ioctl(can_fd, SIOCSCANBAUDRATE, &ifr);
if (ret) {
goto abort;
}
}
-
if (bittime_count) {
-	bittime = &u.bittime;
+	bittime = (struct can_bittime *)&ifr.ifr_ifru;
if (bittime_count == 2) {
bittime->type = CAN_BITTIME_BTR;
bittime->btr.btr0 = bittime_data[0];
@@ -233,7 +226,7 @@
bittime->std.sam);
}

-	ret = ioctl(can_fd, SIOCSCANCUSTOMBITTIME, &u.ifr);
+	ret = ioctl(can_fd, SIOCSCANCUSTOMBITTIME, &ifr);
if (ret) {
goto abort;
}
@@ -241,20 +234,20 @@
}

if (set_ctrlmode != 0) {
-	ctrlmode = &u.ctrlmode;
+	ctrlmode = (can_ctrlmode_t *)&ifr.ifr_ifru;
*ctrlmode = new_ctrlmode;
if (verbose)
printf("ctrlmode: %#x\n", new_ctrlmode);
-	ret = ioctl(can_fd, SIOCSCANCTRLMODE, &u.ifr);
+	ret = ioctl(can_fd, SIOCSCANCTRLMODE, &ifr);
if (ret) {
goto abort;
}
}

if (new_mode != -1) {
-	mode = &u.mode;
+	mode = (can_mode_t *)&ifr.ifr_ifru;
*mode = new_mode;
-	ret = ioctl(can_fd, SIOCSCANMODE, &u.ifr);
+	ret = ioctl(can_fd, SIOCSCANMODE, &ifr);
if (ret) {
goto abort;
}

