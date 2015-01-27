Message-ID: <54C74D86.9030101@xenomai.org>
Date: Tue, 27 Jan 2015 09:34:14 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20150127081901.GA5658@localhost.localdomain>
In-Reply-To: <20150127081901.GA5658@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm on mercury
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Cochran <richardcochran@gmail.com>, xenomai@xenomai.org


Hi Richard,

On 01/27/2015 09:19 AM, Richard Cochran wrote:
> Hallo list,
> 
> I have been just getting to know xenomai-3 after a long time of
> xenomai abstinence.  IIRC, there has been some talk in the past of
> supporting rtdm in mercury for both user space and drivers.  But
> looking at the present state, I don't see any sign of this having been
> implemented.
> 
> Am I missing something?
> 
> [ background: wanting to write a driver for custom FPGA based hardware
>   device, and the driver should work with and without cobalt.  I have
>   done this before by making the driver code portable to both normal
>   kernel and rtdm.  It would be nice to be able to write a pure rtdm
>   driver and have it "just work" in a plain kernel. ]
> 

This work is still in the planning stage. We had to wait for the dust to
settle on the RTDM API changes that took place in 3.x. Implementing a
revised version of the native incarnation of RTDM is next.

-- 
Philippe.

