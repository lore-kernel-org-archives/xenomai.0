Date: Thu, 6 Aug 2015 22:56:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150806205601.GV2914@hermes.click-hack.org>
References: <55C17C8E.5000909@gatech.edu> <55C3AEBE.9080603@xenomai.org>
 <55C3C3F8.1090808@gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55C3C3F8.1090808@gatech.edu>
Subject: Re: [Xenomai] analogy calibration issue(s)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Aug 06, 2015 at 04:30:48PM -0400, Yogi A. Patel wrote:
> When I run
> 
> sudo ./analogy_calibrate --device=analogy0 --output=file
> 
> I see
> 
> [ 1124.191097] analogy_calibra[2822]: segfault at 7 ip 00007f10b88c6a03 sp
> 00007fffaee2bb40 error 4 in libc-2.19.so[7f10b887b000+1bb000]
> 
> on two computers running Xenomai RC5 with Linux 3.18.12 both with NI DAQs
> installed (M-Series).

Please upgrade to rc6, so that you and Jorge actually talk about the
same version.

-- 
					    Gilles.
https://click-hack.org

