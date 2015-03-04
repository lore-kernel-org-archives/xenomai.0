Date: Wed, 4 Mar 2015 10:17:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150304091730.GD30672@hermes.click-hack.org>
References: <CA+C+_XRjP-YeDZgOmumU+AMbuUOJEtiuJ7v5U-ijRrTQWv-qrw@mail.gmail.com>
 <20150303004406.GA30672@hermes.click-hack.org>
 <CA+C+_XTpLYq94Vxvcz3snmx7hCPbz41FajCQm3Vc=DHvYXue0A@mail.gmail.com>
 <CA+C+_XQZVy=ryVnWCzXyFCOS+SMfAC8p66-PLWMQuZNOn+hG0w@mail.gmail.com>
 <CA+C+_XR=BrBzNX4EJpLob1Bmn6uhM6rAfUxS7acPPCUpBM2TVg@mail.gmail.com>
 <20150303151134.GC30672@hermes.click-hack.org>
 <CA+C+_XSXyZPLo6OaGp-yEbVJ0H=yUSjXtR22Zn6pAncr_YYjKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+C+_XSXyZPLo6OaGp-yEbVJ0H=yUSjXtR22Zn6pAncr_YYjKA@mail.gmail.com>
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

On Tue, Mar 03, 2015 at 09:07:23PM -0600, Mathew Benson wrote:
> I didn't actually build or Xenomai myself.  I used the prebuilt
> MachineKit.  I will check with the MachineKit maintainers, but is there a
> way to determine if the patch is applied from the as-built?

uname -a
cat /proc/ipipe/version

-- 
					    Gilles.

