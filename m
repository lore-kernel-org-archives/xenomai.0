Message-ID: <2ff1a98a0805150612x62f8a1a9te843a27911244e72@domain.hid>
Date: Thu, 15 May 2008 15:12:32 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2ff1a98a0805150228l7d99b025rae68cec2c02e4246@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <18475.12268.192581.316526@domain.hid>
	<7df088046ee0bd577cb7040650d79a05@domain.hid>
	<2ff1a98a0805150228l7d99b025rae68cec2c02e4246@domain.hid>
Subject: Re: [Xenomai-help] VxWorks skin problem concerning WIND_TCBstructure
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: matthieu.connaulte_xenomai@domain.hid
Cc: xenomai@xenomai.org

On Thu, May 15, 2008 at 11:28 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Thu, May 15, 2008 at 8:10 AM, Matthieu
> <matthieu.connaulte_xenomai@domain.hid> wrote:
>  I think
>> that VxWorks Task Control Block ,implemeted by  WIND RIVER, is keeping the
>> context in hard real-time. That's why I would like to know if there are
>> other possibilities ?
>
> Yes, there are possibilities: fix your code not to use such internal
> data as the WIND_TCB members.

Even VxWorks documentation considers accessing WIND_TCB directly as a
bad practice. See the doc of taskInfoGet at:

http://spacegrant.colorado.edu/~dixonc/vxworks/docs/vxworks/ref/taskShow.html

So, what I would agree we can do is implement taskInfoGet.

-- 
 Gilles

