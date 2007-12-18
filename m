Date: Tue, 18 Dec 2007 09:32:50 -0800 (PST)
From: Jonathan Day <imipak@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <835557.38744.qm@domain.hid>
Subject: [Adeos-main] Using ADEOS to run multiple Linux kernels
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hi,

According to the white papers and other documentation
on the ADEOS site, it is possible to use the ADEOS
nanokernel to run multiple kernels in parallel.
However, what I am not entirely sure on is how you
would actually do so.

What I am wanting to do is run two Linux kernels in
parallel, minus the overheads of virtualization (I
don't need it), where the only requirements are that
if one Linux kernel crashes, it won't take out the
other and that there's some way of restarting a
crashed kernel.

The documentation I can find suggests that ADEOS would
be perfect for the job. It's lightweight, doesn't have
anything I don't need, and is designed to run multiple
kernels within it. The only bit left is to find an
example, a HOWTO, or some other information on how I'd
actually do something like this.

Can anyone give me a recommendation on where I'd find
the information I'd need?

Jonathan



      ____________________________________________________________________________________
Looking for last minute shopping deals?  
Find them fast with Yahoo! Search.  http://tools.search.yahoo.com/newsearch/category.php?category=shopping

