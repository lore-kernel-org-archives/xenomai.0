References: <56795E20.1010102@isc.cnr.it>
From: Jorge Ramirez Ortiz <jro@xenomai.org>
Message-ID: <5679E096.3030807@xenomai.org>
Date: Tue, 22 Dec 2015 18:45:26 -0500
MIME-Version: 1.0
In-Reply-To: <56795E20.1010102@isc.cnr.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Programming Xenomai+analogy
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 12/22/2015 09:28 AM, GianPiero Puccioni wrote:
> Hi,
> 
> I am trying to use xenomai to accomplish a, I think, simple task, but I
> have never used real time programs before so I have some problems.
> 
> What I need is to use a  National Instruments PCI-MIO-16E-4 AD/DA to
> read data from the AD, do some simple operations on it, and output the
> result on the DA at the fastest possible frequency, with as little jitter
> as possible.
> 
> I set up a machine for this with Xenomai3 (cobalt) and everything seems to work.
> I can run "latency" with max latency around 3-4 us. the analogy
> libraries are installed, the board is recognized and the test programs
> are able to read and write to it.
> 
> The problem is how to write a realtime program for this task. Is there
>  documentation at the basic level on howto do that or some place where I
> can find examples for similar programs?


have you tried reading the Xenomai demo code or the analogy utilities?
http://git.xenomai.org/xenomai-3.git/tree/utils/analogy

