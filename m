Message-ID: <BLU0-SMTP361A4801D1D3A47014E894BAF010@phx.gbl>
From: Chiara <chiaracapretti@hotmail.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Oct 2013 07:48:46 +0200
MIME-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: [Xenomai] Help with the histogram of latency test
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,
I'm new of xenomai.=20
I would analyze latency performance on different architecture and I want =
to use the histogram that latency produce with the option -g.
But when I use the script histo.gp I visualize this warning message:
"skipping unreadable file, no data in plot"

I write this command

gnuplot -e 'input_file=3D"/usr/xenomai/bin/.latency -t1 - g gr =
";output_file=3D"/usr/xenomai/bin/gr";graph_title=3D"graph";' =
/usr/xenomai/bin/histo.gp

Thanks!!=

