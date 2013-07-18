Message-ID: <51E79279.9040102@aaton.com>
Date: Thu, 18 Jul 2013 09:00:09 +0200
From: Nicolas Pinault <nicolasp@aaton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] i.MX6 setup
Reply-To: nicolasp@aaton.com
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I'm starting a new project where I have to use Linux on a i.MX6. The new 
system has real time constraints. I have chosen xenomai for the real 
time part of the software.
I have followed Freescale documents to setup a Ubuntu virtual machine to 
run ltib and cross-compile the Linux distribution delivered by 
Freescale. I now have a i.MX6 board (Sabre Smart Devices Board) booting 
U-Boot and running standard Freescale Linux.
What's next ?
I have read xenomai documentation but some points are not clear.
It is said that patches have to be applied on a vanilla kernel. I guess 
the Freescale Linux distribution does not have a vanilla kernel. So how 
can I apply patches on it ?

Does anyone have a detailed "howto" to setup a xenomai patched Linux for 
a i.MX6 board ?

Regards,
Nicolas

PS : I guess that topic has already been discussed here but I have not 
found any archive for the current mailing list.


