References: <e91afecfce4b074fe8e8bcce5d868237@stupar.com>
From: Jorge Ramirez <jro@xenomai.org>
Message-ID: <b049cec3-3df5-d18d-a50e-9a9654f9094f@xenomai.org>
Date: Mon, 28 Nov 2016 14:46:10 +0100
MIME-Version: 1.0
In-Reply-To: <e91afecfce4b074fe8e8bcce5d868237@stupar.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Migrating device drivers from RTLinux to
 Xenomai/Analogy
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: andrija@stupar.com, xenomai@xenomai.org

On 11/25/2016 11:03 PM, andrija@stupar.com wrote:
> How much of an effort would it be to port said drivers to 
> Xenomai/Analogy, approximately? Is this relatively straightforward, or 
> does it require writing from scratch? 

Hi Andrija

It really depends on the quality of the linux driver that you are trying 
to port and the RTLinux services that you depend on. Can your driver run 
on a vanilla kernel?
Maybe you could post your driver to github and we can then try to give 
you a ballpark estimate.

jorge

