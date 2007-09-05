Message-ID: <43afefbf0709050215w4a5705b9x8397b2b58a573674@domain.hid>
Date: Wed, 5 Sep 2007 11:15:28 +0200
From: "Ravid Baruch Naali" <ravidbn@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_27503_24793882.1188983728572"
Subject: [Xenomai-core] Automated performance testings
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_27503_24793882.1188983728572
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Moving to a new thread subject.

The following thread will be dedicated to development of the Automated
performance testing and it's presentation.

At first stage an infrastructure will be design and created. later on the
presentation and automation will be discussed.

Infrastructure design:
Option 1:
- The time measurements will based on the nucleus API functions.
- On entering the function a timer will be activated and stop at the
function exit point.
- When test execution complete all the time measurements of each function
will be summed up and average will be calculated.

Advantages:
- One infrastructure for all skins
Disadvantage:
- The specific skin delays will not be measured.
- Inserting a system delay

Implementation method:
- Either by code integrated into the nucleus code scoped in a precomiplation
define.
- Or by a preloaded or statically compiled library which will grab every
nucleus API function run its timer and only then call the origin nucleus
function.

Option 2:
- In the application level
  - Create a library which calculate an present results.
  - using it will require the test to call specific API functions.

Advantage:
- A skin oriented result
- No delay in the underlying system
- provide any user the ability to test her own application

Option 3:
- A combination of 1 and 2:
  - A library which collect the data and later on will present it.
  - An API for the application layer.
  - Same/different API to integrate into the nucleus.

Advantage:
- More flexibility
- Can also provide a mean to hunt the exact delay factor.
- Usable as developing tool
Disadvantage:
- Hard to maintain a uniform results.

Waiting for your comments/suggestions/corrections.
Ravid
2007/9/4, Jan Kiszka <jan.kiszka@domain.hid>:

> Ravid Baruch Naali wrote:
> > The automated chart seems exactly the thing for me (I have some testing
> > tools development experience).
> >
> > I'll look into it and will soon send a initial design.
>
> Hurray! You just deserved an option for a free beer! Now you just need
> to post the first related patch - and manage to meet me personally (the
> latter may be a bit trickier than the former ;)).
>
> >
> > Of course any pinters/advice/suggestions will be highly appreciated.
>
> Let's start with creating the infrastructure for the targets firsts.
> Once we have more tests with unified output locally on the Xenomai
> targets, we can think about how to transfer this data to a central
> database and how to visualise that database on the web.
>
> Jan
>
>
>


-- 
Ravid Baruch Naali
E-mail: ravidbn@domain.hid
Mobile: 052-5830021
Home/Office:04-6732729

------=_Part_27503_24793882.1188983728572
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="rtl"><div dir="ltr">Moving to a new thread subject.</div>
<div dir="ltr">&nbsp;</div>
<div dir="ltr">The following thread will be dedicated to development of the Automated performance testing and it&#39;s presentation.</div>
<div dir="ltr">&nbsp;</div>
<div dir="ltr">At first stage an infrastructure will be design and created. later on the presentation and automation will be discussed.</div>
<div dir="ltr">&nbsp;</div>
<div dir="ltr">Infrastructure design:</div>
<div dir="ltr">Option 1:</div>
<div dir="ltr">- The time measurements will based on the nucleus API functions.</div>
<div dir="ltr">- On entering the function a timer will be activated and stop at the function exit point.</div>
<div dir="ltr">- When test execution complete all the time measurements of each function will be summed up and average will be calculated.</div>
<div dir="ltr">&nbsp;</div>
<div dir="ltr">Advantages:</div>
<div dir="ltr">- One infrastructure for all skins</div>
<div dir="ltr">Disadvantage:</div>
<div dir="ltr">- The specific skin delays will not be measured.</div>
<div dir="ltr">- Inserting a system delay</div>
<div dir="ltr">&nbsp;</div>
<div dir="ltr">Implementation method:</div>
<div dir="ltr">- Either by code integrated into the nucleus code scoped in a precomiplation define.</div>
<div dir="ltr">- Or by a preloaded or statically compiled&nbsp;library which will grab every nucleus API function run its timer and only then call the origin nucleus function.</div>
<div dir="ltr">&nbsp;</div>
<div dir="ltr">Option 2:</div>
<div dir="ltr">- In the application level</div>
<div dir="ltr">&nbsp; - Create a library which calculate an present results.</div>
<div dir="ltr">&nbsp; - using it will require the test to call specific API functions.<br><br>Advantage:</div>
<div dir="ltr">- A skin oriented result</div>
<div dir="ltr">- No delay in the underlying system</div>
<div dir="ltr">- provide any user the ability to test her own application</div>
<div dir="ltr">&nbsp;</div>
<div dir="ltr">Option 3:</div>
<div dir="ltr">- A combination of 1 and 2:</div>
<div dir="ltr">&nbsp; - A library which collect the data and later on will present it.</div>
<div dir="ltr">&nbsp; - An API for the application layer.</div>
<div dir="ltr">&nbsp; - Same/different API to integrate into the nucleus.</div>
<div dir="ltr">&nbsp;</div>
<div dir="ltr">Advantage:</div>
<div dir="ltr">- More flexibility</div>
<div dir="ltr">- Can also provide a mean to hunt the exact delay factor.</div>
<div dir="ltr">- Usable as developing tool</div>
<div dir="ltr">Disadvantage:</div>
<div dir="ltr">- Hard to maintain a uniform results.</div>
<div dir="ltr">&nbsp;</div>
<div dir="ltr">Waiting for your comments/suggestions/corrections.</div>
<div dir="ltr">Ravid</div>
<div><span class="gmail_quote">2007/9/4, Jan Kiszka &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt;:</span></div>
<blockquote class="gmail_quote" style="BORDER-RIGHT: #ccc 1px solid; PADDING-RIGHT: 1ex; PADDING-LEFT: 1ex; MARGIN: 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Ravid Baruch Naali wrote:<br>&gt; The automated chart seems exactly the thing for me (I have some testing
<br>&gt; tools development experience).<br>&gt;<br>&gt; I&#39;ll look into it and will soon send a initial design.<br><br>Hurray! You just deserved an option for a free beer! Now you just need<br>to post the first related patch - and manage to meet me personally (the
<br>latter may be a bit trickier than the former ;)).<br><br>&gt;<br>&gt; Of course any pinters/advice/suggestions will be highly appreciated.<br><br>Let&#39;s start with creating the infrastructure for the targets firsts.
<br>Once we have more tests with unified output locally on the Xenomai<br>targets, we can think about how to transfer this data to a central<br>database and how to visualise that database on the web.<br><br>Jan<br><br><br>
</blockquote><br><br clear="all"><br>-- <br>Ravid Baruch Naali<br>E-mail: <a href="mailto:ravidbn@domain.hid">ravidbn@domain.hid</a><br>Mobile: 052-5830021<br>Home/Office:04-6732729 </div>

------=_Part_27503_24793882.1188983728572--

