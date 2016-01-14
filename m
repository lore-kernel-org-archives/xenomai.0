Date: Thu, 14 Jan 2016 18:34:23 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20160114183423.69665622@md1em3qc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] ipipe x86_64 huge page ioremap
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Hey,

the 4.1 kernel supports mapping IO memory using huge pages.
0f616be120c632c818faaea9adcb8f05a7a8601f ..
6b6378355b925050eb6fa966742d8c2d65ff0d83

In ipipe memory that gets ioremapped will get pinned using
__ipipe_pin_mapping_globally, however in the x86_64 case that function
uses vmalloc_sync_one which must only be used on 4k pages.

We found the problem when using the kernel in a VBox VM, where the
paravirtualized PCI device has enough iomem to cause huge page
mappings. When loading the device driver you will get a BUG caused by
__ipipe_pin_mapping_globally.

I will work on a fix for the problem. But i would also like to
understand the initial purpose of the pinning. Is it even supposed to
work for io memory as well? It looks like a way to commit address space
changes right down into the page tables, to avoid page-faults in the
kernel address space. Probably for more predictable timing ...

regards,
Henning

