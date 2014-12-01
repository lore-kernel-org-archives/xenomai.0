Date: Mon, 1 Dec 2014 15:39:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141201143957.GH23220@hermes>
References: <CAPozGf=zAFgV=fbinambu1_xEiR3qD7Affppw-i6ZbD4nvJsRw@mail.gmail.com>
 <20141128111325.GD5069@hermes>
 <CAPozGf=6OQBChvSAfypNH7KpAReg+u6PS3dhEJDtVZ-jrnW7bg@mail.gmail.com>
 <CAPozGfkxmv+7=Q3LXAmOv_eTPZ08XV3SO9SETPomSAs+bbxV0A@mail.gmail.com>
 <CAPozGfk9LizYFbCRKUDS1-mhX+bw3fOpgqzwF6AcH64Pspw4Gg@mail.gmail.com>
 <20141128182141.GB4817@hermes>
 <CAPozGfk-okS5TDn-zPua3uvHkcppm3CpnqAKXYs6-VWVPb4cpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPozGfk-okS5TDn-zPua3uvHkcppm3CpnqAKXYs6-VWVPb4cpg@mail.gmail.com>
Subject: Re: [Xenomai] Section mismatch - Porting Xenomai to
 linux-xlnx-V14.5 zynq SoC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Sini <jhnsini@gmail.com>
Cc: xenomai@xenomai.org

On Mon, Dec 01, 2014 at 03:35:51PM +0100, John Sini wrote:
>  Hi,
> 
> 
> Thank you for your reply. I have disabled lockdep by disabling following
> two options in Kernel configuration :Lock debugging:prove locking
> correctness and  Lock debugging: detect incorrect freeing of live locks.
> The problem that i am facing now is:

Does the exact same .config file work on an unpatched kernel?

-- 
					    Gilles.

