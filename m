Date: Fri, 18 Sep 2015 14:29:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150918122903.GC7301@hermes.click-hack.org>
References: <CAFkYNwaqLYu7vAAyAt6Q9qfKL4iBa+N1BuzgJWhN6z4NfA5U=g@mail.gmail.com>
 <44k2rqz38u.fsf@be-well.ilk.org>
 <CAFkYNwYJ7ah+U97Pwuqwf9Phg=J0rTjr1txfGtg0FuoN2oP7cg@mail.gmail.com>
 <20150917133220.GB31663@hermes.click-hack.org>
 <CAFkYNwacX=h7trKNEBq=KZX627nRA7u6zk6YoEOLj8_J_LEa1Q@mail.gmail.com>
 <20150918074633.GA7301@hermes.click-hack.org>
 <CAFkYNwaBpwoC7rZBV4eRd7XEZ+c1GzNJZN9ZY_n9WO184A=pFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFkYNwaBpwoC7rZBV4eRd7XEZ+c1GzNJZN9ZY_n9WO184A=pFQ@mail.gmail.com>
Subject: Re: [Xenomai] Error code -19
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: vibnwis <vibnwis@gmail.com>
Cc: xenomai@xenomai.org

On Sat, Sep 19, 2015 at 12:24:38AM +1200, vibnwis wrote:
> I have checked in .config. However, I am not sure what string to search for
> device tree. Would you please advise what string would it be for the clock?
> 
> In .config
> 
> CONFIG_ARM_GLOBAL_TIMER=y

Yes, this looks like the right option. Is the global timer declared
in the device tree?

-- 
					    Gilles.
https://click-hack.org

