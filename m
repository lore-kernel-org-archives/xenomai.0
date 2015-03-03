Date: Tue, 3 Mar 2015 01:44:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150303004406.GA30672@hermes.click-hack.org>
References: <CA+C+_XRjP-YeDZgOmumU+AMbuUOJEtiuJ7v5U-ijRrTQWv-qrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+C+_XRjP-YeDZgOmumU+AMbuUOJEtiuJ7v5U-ijRrTQWv-qrw@mail.gmail.com>
Subject: Re: [Xenomai] gdbserver hangs on rt_task_create()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathew Benson <mathew.benson@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Mar 02, 2015 at 06:16:42PM -0600, Mathew Benson wrote:
> When I step through my code, gdbserver hangs on rt_task_create() and never
> comes back.  I'm using Xenomai 2.6.4.  I noticed in the archives several
> other people ran into similar or identical problems in previous versions,
> but I don't see a fix or workaround.

As far I know there has been several such cases which have all been
solved. But such fixes may be in the I-pipe patches, so, what
version of the I-pipe patch are you using ?

-- 
					    Gilles.

