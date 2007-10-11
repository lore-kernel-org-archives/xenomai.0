Message-ID: <470DCFD2.1000908@domain.hid>
Date: Thu, 11 Oct 2007 09:25:06 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
References: <470CB974.6040605@domain.hid>
In-Reply-To: <470CB974.6040605@domain.hid>
Content-Type: multipart/mixed; boundary="------------030407000700010908090907"
Subject: Re: [Xenomai-help] Passing data from device init to open function
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

This is a multi-part message in MIME format.
--------------030407000700010908090907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is something I try to avoid (replying to my own messages), but I'll 
do it this time.

Johan Borkhuis wrote:
> Hello,
>
> I am facing the following problem. During device initialization I am 
> filling a structure with device specific data. This structure is 
> provided to the Linux driver using pci_set_drvdata. Now I want my 
> Xenomai driver to have access to this data as well.
>   

I made a fix for the problem I described, but I would also like to 
propose a change to the rtdm_device structure.

What I did to solve this problem is add the following statement to my 
device initialization function (the PCI probe function) after the 
pci_set_drvdata:

    MyDevice *unit;
    ....
    pci_set_drvdata(dev, unit);
    my_rtdm_device.device_id = (int)dev;

In my ops-functions I can now use the following statement to access the 
device data:

int myrtdm_open_nrt(struct rtdm_dev_context    *context,
                 rtdm_user_info_t              *user_info,
                 int                            oflags)
{
    MyDevice *unit = pci_get_drvdata((struct pci_dev 
*)context->device->device_id);

This does work, but only as long as sizeof(int) == sizeof(<pointer>), 
which is true on 32 bit systems, but not on 64 bit systems. So I would 
like to add an extra pointer field to the rtdm_device structure, 
pointing to some device-data to allow this to work on both 32 and 64 bit 
systems.

I attached a diff-file containing a patch to rtdm_driver.h that makes 
this change.

Kind regards,
    Johan Borkhuis


--------------030407000700010908090907
Content-Type: text/plain;
 name="xeno.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xeno.diff"

diff -u -r org/xenomai-2.3.2/include/rtdm/rtdm_driver.h xenomai-2.3.2/include/rtdm/rtdm_driver.h
--- org/xenomai-2.3.2/include/rtdm/rtdm_driver.h	2007-02-19 15:09:49.000000000 +0100
+++ xenomai-2.3.2/include/rtdm/rtdm_driver.h	2007-10-11 09:15:36.000000000 +0200
@@ -428,6 +428,9 @@
     /** Driver definable device ID */
     int                             device_id;
 
+    /** Driver definable device data */
+    void                            *device_data;
+
     /** Data stored by RTDM inside a registered device (internal use only) */
     struct rtdm_dev_reserved        reserved;
 };


--------------030407000700010908090907--

