From: Paul <paul_c@tuxcnc.org>
Date: Sun, 19 Jan 2014 00:27:29 +0000
References: <CAN1+YZVvgPNNHFub5QAkw6SeSUPuf1dv_94kYGqhbjMpNt70Sg@mail.gmail.com>
 <52DB0D2A.6020200@xenomai.org>
 <CAN1+YZXsL1m62XTD=40N7HZHMoY+yXg5fxsdnrTrN=9rZdS-3Q@mail.gmail.com>
In-Reply-To: <CAN1+YZXsL1m62XTD=40N7HZHMoY+yXg5fxsdnrTrN=9rZdS-3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201401190027.30040.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] Fwd: Kernel Compilation Problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Saturday 18 January 2014, Andy Pugh wrote:
> (The only reason I haven't tried it is that it is a grub option, and
> I don't think the Udoo board is using grub)

isolcpus is not a "grub option", it is a kernel argument passed by the 
boot manager. For most ARM systems, this will be u-boot, in which case 
I'd suggest you go and read the section on bootargs in the u-boot 
manual.


