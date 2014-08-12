Message-ID: <53EA690E.50101@xenomai.org>
Date: Tue, 12 Aug 2014 21:20:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <D36F9745-B497-4700-8BDC-92281227E1D4@gatech.edu>
In-Reply-To: <D36F9745-B497-4700-8BDC-92281227E1D4@gatech.edu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Parallel Computing?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>, xenomai@xenomai.org

On 08/12/2014 08:56 PM, Yogi A. Patel wrote:
> Hi -
> 
> I am interested in using Xenomai with multiple cores. When I run “cat
> /proc/cpuinfo | grep “model name” I see that there are two CPUs
> listed.
> 
> My system using data acquisition from a NI DAQ (using ANALOGY
> driver), processes it with some model, and then provides some output
> through the NI DAQ.
> 
> I would like to make the system faster (both real-time and
> computation) by off loading the acquisition and data processing parts
> to one CPU and then letting the user interactions and the GUI
> (Qt-based) processed by the other CPU.
> 
> Is this possible? If so, any examples on how to do this?

Xenomai never migrates a thread running in primary mode, so the job of
deciding on which cpu to run a task is left to Linux. So, simply use
sched_setaffinity to decide on which cpu to run a thread.

-- 
                                                                Gilles.

