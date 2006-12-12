Message-ID: <457E5C81.3060006@domain.hid>
Date: Tue, 12 Dec 2006 08:38:41 +0100
From: Niklaus Burren <niklaus.burren@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] rt_misc_get_io_region()
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

We want to write a Xenomai application that can access the
GPIO pins of our ARM-Prozessor (PXA-270). To get the memory
region I found the function rt_misc_get_io_region(). Unfortunately
there is no discription of this function in the API documentation.
Does this function work like request_mem_region()?

After the call of the rt_misc_get_io_region() fuction it is also 
necessary to call the ioremap() function?

Please can you give me a little example, how you can map and access 
memory in Xenomai?

I think that is a topic that is interessting for a lot of people.

Regards

Niklaus Burren

