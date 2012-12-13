MIME-Version: 1.0
Date: Thu, 13 Dec 2012 10:21:20 +0100
Message-ID: <CAPpP=rMVEY5_Ris9_HGPpsUFht-CdvPdWhPm7jtJ4qfZoyVjKw@mail.gmail.com>
From: alex alex <duch.alexandre@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] RTDM - Dynamic linking of device
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I need to link new devices once my module is loaded and I'd like to know if
we can do this with RTDM?
Are we forced to link the device in the "_init" fonction ? Or is there an
other way to do the connection device/driver than using
rtdm_dev_register<http://www.xenomai.org/documentation/trunk/html/api/group__devregister.html#ga6a191b3d206680c48cad2047adb9fc98>wich
doesn't allow to do what I want?

Thanks for your answer.

Alex.
