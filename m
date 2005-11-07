Message-ID: <436F60D3.9080104@domain.hid>
Date: Mon, 07 Nov 2005 09:12:35 -0500
From: Sean McGranaghan <smm@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] RTDM driver path question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello all,

I am in the process of writing a simple device driver for Xenomai 2.0 
using RTDM. I have a skeleton driver module loading and registering with 
RTDM. (I can see the entries in the /proc filesystem when the module 
loads.) I now want to write a driver validation application to exercise 
the interface, but don't know how Linux device nodes map to Xenomai 
devices. Do I have to manually create device nodes or are they built 
with udev? (I am more familiar with traditional Unix style /dev entries, 
udev is new to me.) Do Xenomai devices use the Linux filesystem layer at 
all? Does Xenomain keep a separate namespace/registry of named devices?

If I missed this in the documentation please feel free to redirect me as 
needed. Any help is appreciated.

Thanks,
Sean McGranaghan


