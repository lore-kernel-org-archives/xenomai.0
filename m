Message-ID: <470CB974.6040605@domain.hid>
Date: Wed, 10 Oct 2007 13:37:24 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Passing data from device init to open function
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

Hello,

I am facing the following problem. During device initialization I am 
filling a structure with device specific data. This structure is 
provided to the Linux driver using pci_set_drvdata. Now I want my 
Xenomai driver to have access to this data as well.
I am planning to use the dev_private area for this, and have it contain 
a pointer to the same structure. The rtdm_dev_context structure is only 
available after the open call and not in the device init function. So I 
am searching for a safe way to transfer data from the device init 
function to the open function.

Is there a way to transfer data from the device init function to the 
open (or other) functions in such a way that it is possible to have 
multiple devices that can be opened multiple times?

Kind regards,
    Johan Borkhuis


