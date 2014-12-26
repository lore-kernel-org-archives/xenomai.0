Date: Fri, 26 Dec 2014 16:58:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141226155843.GB1692@daedalus>
References: <45638F48-3A57-4E45-929F-5514BAA38A72@gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45638F48-3A57-4E45-929F-5514BAA38A72@gatech.edu>
Subject: Re: [Xenomai] Spurious relax test?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>
Cc: xenomai@xenomai.org

On Fri, Dec 26, 2014 at 12:46:58AM -0500, Yogi A. Patel wrote:
> Hi -
> 
> I’ve implemented the code provided on the Xenomai website for finding spurious relaxes in Xenomai 2 - however I’m a bit skeptical about whether or not I’ve implemented it correctly since I don’t ever see any output to the terminal.
> 
> Is there any way to “induce” a relax to test the implementation and know that it is in fact catching any drops to secondary mode?

See examples/native/sigdebug.c

-- 
					    Gilles.

