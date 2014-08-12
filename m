From: "Yogi A. Patel" <yapatel@gatech.edu>
Message-Id: <D36F9745-B497-4700-8BDC-92281227E1D4@gatech.edu>
Date: Tue, 12 Aug 2014 14:56:21 -0400
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain;
	charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Parallel Computing?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi -

I am interested in using Xenomai with multiple cores. When I run =93cat =
/proc/cpuinfo | grep =93model name=94 I see that there are two CPUs =
listed.

My system using data acquisition from a NI DAQ (using ANALOGY driver), =
processes it with some model, and then provides some output through the =
NI DAQ.

I would like to make the system faster (both real-time and computation) =
by off loading the acquisition and data processing parts to one CPU and =
then letting the user interactions and the GUI (Qt-based) processed by =
the other CPU.

Is this possible? If so, any examples on how to do this?

Yogi

