References: <CA+X=5XiGUYkKiAiffg-A82ywtSJjpcbJS2C1fV4aOiHQw2i5Gw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5be8ae5e-24de-b98c-6b5a-b95cc50725a9@xenomai.org>
Date: Sun, 6 Nov 2016 10:35:15 +0100
MIME-Version: 1.0
In-Reply-To: <CA+X=5XiGUYkKiAiffg-A82ywtSJjpcbJS2C1fV4aOiHQw2i5Gw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai/Cobalt on ARM64
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Vivien LEGER <vivien.leger@gmail.com>, xenomai@xenomai.org

On 11/02/2016 02:19 PM, Vivien LEGER wrote:
> Hello everyone.
> 
> I understand that xenomai is not quite ready for ARM64 and that no ETA is
> yet determined.
> 
> Would you have a rough estimate of the target for this version. Is ARM64 a
> big thing to you or is it still considered nice to have?

FWIW, I'm personally interested in using arm and arm64 as the reference
architectures of a more "radical", lean and mean and scalable dual
kernel implementation in the future than Xenomai has ever been. Having a
stable arm64 port in Xenomai 3 would pave this way.

Now, this is all wishful thinking until time can be invested in fixing
up the I-pipe patch for the Linux 4.1 series as a starting point, and so
far this did not happen.

> 
> I have also a thought for Gilles, that wrote so many post.I ve rid him for
> hours trying to understand what i was doing wrong. The page on the xenomai
> website truly shook me.
> 

Gilles was one of a kind; who is unique won't be forgotten.

-- 
Philippe.

