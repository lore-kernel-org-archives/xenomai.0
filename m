From: <giorgiobuffa.work@gmail.com>
Date: Mon, 29 Jun 2015 10:45:49 +0200
Message-ID: <000001d0b248$002ca660$0085f320$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: it
Subject: [Xenomai] How to profile/trace a Xenomai application?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello list!
I'm planning to develop a real-time Xenomai application using Linux 3.16.7
and Xenomai 2.6.4. I would like to receive some hints on how to
profile/trace the behaviour of my Xenomai application.

My primary concern is how to measure execution times of the functions
called by Xenomai threads.

It would be also interesting to have a way to monitor the behaviour of the
schedulers to understand/validate thread activation times, state
transitions and preemptions, response times to external or periodic events,
deadline misses, and so on. However, I do realize that this is just asking
too much... :)

Q1: Which tools may I use for that purposes? Clearly, a tool with a
graphical interface would be the best, but this is not essential! :)

After some research, I was thinking to explore the following tools, but I'm
not sure that they can all be used in a Xenomai dual-kernel configuration.
In other words, I'm not sure they would be aware of Xenomai threads and
their behaviour (e.g. their call graph, or the time spent in each function
being called), as I'm not sure they would be aware of the presence and the
decisions made by the Nucleos-RT scheduler.

* I-pipe tracer
  <http://xenomai.org/2014/06/using-the-i-pipe-tracer/>
* perf
  <https://perf.wiki.kernel.org/index.php/Tutorial>
* OProfile
  <http://oprofile.sourceforge.net/news/>
* Intel VTune Amplifier
  <https://software.intel.com/en-us/intel-vtune-amplifier-xe>
* ftrace
  <https://www.kernel.org/doc/Documentation/trace/ftrace.txt>
* DTrace
  <https://en.wikipedia.org/wiki/DTrace>

Q2: Am I on the right track, or some of the tools I was thinking to use are
useless for my purposes listed above (in particular, to measure execution
times of the functions called by Xenomai threads).

Thank you for any help and best regards,
Giorgio Buffa


