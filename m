Date: Fri, 21 Jun 2002 10:00:48 +0200
From: Jacob Gorm Hansen <jg@domain.hid>
Subject: Re: [Adeos-main] Address spaces in adeos
Message-ID: <20020621080048.GB271@domain.hid>
References: <3D0F0BA2.969434A3@domain.hid> <20020619051755.75505.qmail@domain.hid> <15632.30733.393799.700979@domain.hid> <20020619130256.GA1529@domain.hid> <3D112024.E4B7C59D@opersys.com> <20020620121703.GA2544@domain.hid> <3D12014D.55739F1A@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <3D12014D.55739F1A@opersys.com>
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: <adeos-main.mail.freesoftware.fsf.org>
List-Unsubscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.freesoftware.fsf.org/pipermail/adeos-main/>
To: Karim Yaghmour <karim@domain.hid>
Cc: adeos-main@gna.org

On Thu, Jun 20, 2002 at 12:22:37PM -0400, Karim Yaghmour wrote:
> 
> L4 is very interesting indeed. Last I read about it, though, its
> licensing was problematic (i.e. couldn't be released "open source"
> because of the funding of the project) and it is very hardware
> dependent (in order to achieve better performance). Is this still
> true?

No. The latest implementations are GPL, and large parts written in C++.

But i386 is still the main supported platform, even though ports for
MIPS and ARM exist.

> I understand the need to be able to migrate entire OSes between
> machines. Because we do not virtualize the physical RAM, this
> may a little harder to do with Adeos. But since we assume that we can
> modify the OSes to better interact with Adeos, then it should not be
> that much harder to implement code that "rewires" the kernels'
> mappings. Of course, this would require some work, and time ... ;)

Yes the recursive address spaces in L4 are a very good thing
for our needs. The only problem is that because all linux processes
are mapped to l4 tasks, there is thread info inside l4 which we 
need to checkpoint and which is hard to get. A nanokernel might be more
helpful because guest kernels could then do their own scheduling, and
the entire kernel would be easy to migrate as one block of memory.

Best,
Jacob

