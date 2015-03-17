Message-ID: <55081474.5010303@xenomai.org>
Date: Tue, 17 Mar 2015 12:48:04 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <OF26567F3C.D06FDAD6-ONC1257E0B.002D4442-C1257E0B.002D4CA1@marposs.com>
In-Reply-To: <OF26567F3C.D06FDAD6-ONC1257E0B.002D4442-C1257E0B.002D4CA1@marposs.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Question about Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: manrico.quadrelli@marposs.com, xenomai@xenomai.org

On 03/17/2015 09:14 AM, manrico.quadrelli@marposs.com wrote:
> Hi,
> I'm interested to implement the new kernel version available from Yocto 
> released for i.MX6Q (i.e. 3.10.17-1.0.2 or 3.10.53-1.1.0) with Xenomai 
> extension and RTnet driver.

Xenomai is likely to be the least of your problems on those
Freescale-originated kernels.

> I would like to know if there is a supported version of patches for 
> Xenomai for these releases of standard Yocto kernel.

Our patches for 3.10.32 apply almost cleanly to 3.10.17-fsl, but may
require a few fixups on .53.

> Any advice on which kind of solution can I test?
> Do you think that Xenomai 3 can solve this problem?

This is not a Xenomai 2 vs 3 issue. 2.x will support a 3.10 kernel the
same way.

> Do you have an estimated date for the relese of a stable version of Xenami 
> 3?

When we are happy with the level of testing, and feedback from people
who are currently helping in raising it.

-- 
Philippe.

