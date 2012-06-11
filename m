Message-ID: <4FD5D27B.2060107@sigmatek.at>
Date: Mon, 11 Jun 2012 13:11:55 +0200
From: Markus Stelzhammer <markus.stelzhammer@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] rtdm_iomap_to_user() - alignment question
Reply-To: markus.stelzhammer@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,


I want to map some physical memory to a special virtual address with 
rtdm_iomap_to_user().
This is basically working but due to some reasons, I need this address 
to be aligned to 0x8000.
So the way I do it now is to give a desired virtual address to 
rtdm_iomap_to_user().
This is working at the moment but I'm afraid if this virtual address is 
already in use, I won't get an address again that is also a multiple of 
0x8000 and only page-aligned.

So my question is if there is a proper way to tell rtdm_iomap_to_user() 
to align the virtual memory to something other than the page-size?


Thanks in advance
Markus

