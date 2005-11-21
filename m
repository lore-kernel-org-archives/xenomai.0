In-Reply-To: <43819D68.4000800@domain.hid>
Subject: Re: [Xenomai-help] pipe fun
Message-ID: <OF0501B44D.C5684C78-ONC12570C0.003940CB-C12570C0.003B0127@domain.hid>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Mon, 21 Nov 2005 11:44:29 +0100
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFA53DFAAC65B8f9e8a93df938690918c4EBBFA53DFAAC65B"
Content-Disposition: inline
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ignacio =?ISO-8859-1?Q?Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

--0__=4EBBFA53DFAAC65B8f9e8a93df938690918c4EBBFA53DFAAC65B
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable



xenomai-help-bounces@domain.hid wrote on 21.11.2005 11:11:52:

>
> This has to be something really simple but I'm hitting a wall. I have=
 a
> rt module that creates a pipe and periodically writes some data to it=
.
> In the following program, the read fails with "No space left on devic=
e":

The reason is as follows:

from rt_pipe_send() docs

 * This service writes a complete message to be received from the
 * associated special device. rt_pipe_send() always preserves message
 * boundaries, which means that all data sent through a single call of
 * this service will be gathered in a single read(2) operation from
 * the special device.

Data is written as a size-bounded message so a reader must provide a
big-enough buffer for the message to be read as a whole. It's possible =
to
send data as a stream (rt_pipe_stream()) but not possible (well, should=
 it
be so?) to read it as a stream (actually, it's possible but as a side
effect - that's why fread() works).

[code]

nucleus::pipe.c::xnpipe_read()

...
        ret =3D (ssize_t)xnpipe_m_size(mh); /* Cannot be zero */
        state->ionrd -=3D ret;

        xnlock_put_irqrestore(&nklock,s);

        if (ret <=3D count)     <---- Is a provided buffer big enough t=
o host
the whole message?
            {
            if (__copy_to_user(buf,xnpipe_m_data(mh),ret))
                ret =3D -EFAULT;
            }
        else
            /* Return buffer is too small - message is lost. */
            ret =3D -ENOSPC;    <---- That's the error you are getting.=

...

[/code]


Why does fread() work? It just uses an additional buffering (by default=
)
and provides a big enough internal buffer for read(). So the whole mess=
age
is read into that buffer upon the first fread() call from your side and=
 a
few subsequent fread() calls just return data from that internal buffer=
. So
it looks like data being read as a stream but that's only a consequence=
 of
additional buffering being made by glibc::fread().

>
>
> int main (void) {
>
>     int r, fd; u_char c;
>
>     fd =3D open("/proc/xenomai/registry/pipes/rt2event", O_RDWR);
>     if (fd < 0) {
>         fprintf(stderr, "ERROR opening pipe: %s\n", strerror(errno));=

>         return -1;
>     }
>
>     for (;;) {
>         r =3D read(fd, &c, sizeof(c));
>         if (r =3D=3D 0) { fprintf(stderr, "ERROR reading (returned 0)=
\n");
> break; }
>         if (r < 0) { fprintf(stderr, "ERROR reading: %s\n",
> strerror(errno)); break; }
>         fprintf(stderr, "%02hX ", c);
>     }
>
>     close(fd);
>
>     return 0;
> }
>
>
> However, the following program works fine!!!
>
>
> int main (void) {
>
>     int r; u_char c;
>
>     FILE *f;
>
>     f =3D fopen("/proc/xenomai/registry/pipes/rt2event", "r+b");
>     if (f =3D=3D NULL) {
>         fprintf(stderr, "ERROR opening pipe: %s\n", strerror(errno));=

>         return -1;
>     }
>
>     for (;;) {
>         r =3D fread(&c, sizeof(c), 1, f);
>         if (r =3D=3D 0) { fprintf(stderr, "ERROR reading (returned 0)=
\n");
> break; }
>         if (r < 0) { fprintf(stderr, "ERROR reading: %s\n",
> strerror(errno)); break; }
>         fprintf(stderr, "%02hX ", c);
>     }
>
>     fclose(f);
>
>     return 0;
> }
>
>
>
> Any clues?
>
> By the way, I noticed a "cat /proc/xenomai/registry/pipes/rt2event |
> xxd" won't work, perhaps due to the same reason?
>

---
Best regards,
Dmitry=

--0__=4EBBFA53DFAAC65B8f9e8a93df938690918c4EBBFA53DFAAC65B
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><font face=3D"Arial"><br>
</font><tt>xenomai-help-bounces@domain.hid wrote on 21.11.2005 11:11:52:<b=
r>
</tt><br>
<tt>&gt; <br>
&gt; This has to be something really simple but I'm hitting a wall. I h=
ave a<br>
&gt; rt module that creates a pipe and periodically writes some data to=
 it.<br>
&gt; In the following program, the read fails with &quot;No space left =
on device&quot;:</tt><br>
<br>
<tt>The reason is as follows:</tt><br>
<br>
<tt>from rt_pipe_send() docs</tt><br>
<br>
<tt> * This service writes a complete message to be received from the</=
tt><br>
<tt> * associated special device. rt_pipe_send() always preserves messa=
ge</tt><br>
<tt> * boundaries, which means that all data sent through a single call=
 of</tt><br>
<tt> * this service will be gathered in a single read(2) operation from=
</tt><br>
<tt> * the special device.</tt><br>
<br>
<tt>Data is written as a size-bounded message so a reader must provide =
a big-enough buffer for the message to be read as a whole. It's possibl=
e to send data as a stream (rt_pipe_stream()) but not possible (well, s=
hould it be so?) to read it as a stream (actually, it's possible but as=
 a side effect - that's why fread() works).</tt><br>
<br>
<tt>[code]</tt><br>
<br>
<tt>nucleus::pipe.c::xnpipe_read()</tt><br>
<br>
<tt>...</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp;ret =3D (ssize_t)xnpipe_m_size(mh); /* =
Cannot be zero */</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp;state-&gt;ionrd -=3D ret;</tt><br>
<br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp;xnlock_put_irqrestore(&amp;nklock,s);</=
tt><br>
<br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp;if (ret &lt;=3D count)	&lt;---- Is a pr=
ovided buffer big enough to host the whole message?</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;{</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (__copy_to_user(buf,xn=
pipe_m_data(mh),ret))</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ret =3D -EF=
AULT;</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp;else</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Return buffer is too s=
mall - message is lost. */</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ret =3D -ENOSPC;	&lt;----=
 That's the error you are getting.</tt><br>
<tt>...</tt><br>
<br>
<tt>[/code]</tt><br>
<br>
<br>
<tt>Why does fread() work? It just uses an additional buffering (by def=
ault) and provides a big enough internal buffer for read(). So the whol=
e message is read into that buffer upon the first fread() call from you=
r side and a few subsequent fread() calls just return data from that in=
ternal buffer. So it looks like data being read as a stream but that's =
only a consequence of additional buffering being made by glibc::fread()=
.</tt><br>
<tt><br>
&gt; <br>
&gt; <br>
&gt; int main (void) {<br>
&gt; <br>
&gt; &nbsp; &nbsp; int r, fd; u_char c;<br>
&gt; <br>
&gt; &nbsp; &nbsp; fd =3D open(&quot;/proc/xenomai/registry/pipes/rt2ev=
ent&quot;, O_RDWR);<br>
&gt; &nbsp; &nbsp; if (fd &lt; 0) {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; fprintf(stderr, &quot;ERROR opening pi=
pe: %s\n&quot;, strerror(errno));<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; return -1;<br>
&gt; &nbsp; &nbsp; }<br>
&gt; <br>
&gt; &nbsp; &nbsp; for (;;) {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; r =3D read(fd, &amp;c, sizeof(c));<br>=

&gt; &nbsp; &nbsp; &nbsp; &nbsp; if (r =3D=3D 0) { fprintf(stderr, &quo=
t;ERROR reading (returned 0)\n&quot;);<br>
&gt; break; }<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; if (r &lt; 0) { fprintf(stderr, &quot;=
ERROR reading: %s\n&quot;,<br>
&gt; strerror(errno)); break; }<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; fprintf(stderr, &quot;%02hX &quot;, c)=
;<br>
&gt; &nbsp; &nbsp; }<br>
&gt; <br>
&gt; &nbsp; &nbsp; close(fd);<br>
&gt; <br>
&gt; &nbsp; &nbsp; return 0;<br>
&gt; }<br>
&gt; <br>
&gt; <br>
&gt; However, the following program works fine!!!<br>
&gt; <br>
&gt; <br>
&gt; int main (void) {<br>
&gt; <br>
&gt; &nbsp; &nbsp; int r; u_char c;<br>
&gt; <br>
&gt; &nbsp; &nbsp; FILE *f;<br>
&gt; <br>
&gt; &nbsp; &nbsp; f =3D fopen(&quot;/proc/xenomai/registry/pipes/rt2ev=
ent&quot;, &quot;r+b&quot;);<br>
&gt; &nbsp; &nbsp; if (f =3D=3D NULL) {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; fprintf(stderr, &quot;ERROR opening pi=
pe: %s\n&quot;, strerror(errno));<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; return -1;<br>
&gt; &nbsp; &nbsp; }<br>
&gt; <br>
&gt; &nbsp; &nbsp; for (;;) {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; r =3D fread(&amp;c, sizeof(c), 1, f);<=
br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; if (r =3D=3D 0) { fprintf(stderr, &quo=
t;ERROR reading (returned 0)\n&quot;);<br>
&gt; break; }<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; if (r &lt; 0) { fprintf(stderr, &quot;=
ERROR reading: %s\n&quot;,<br>
&gt; strerror(errno)); break; }<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; fprintf(stderr, &quot;%02hX &quot;, c)=
;<br>
&gt; &nbsp; &nbsp; }<br>
&gt; <br>
&gt; &nbsp; &nbsp; fclose(f);<br>
&gt; <br>
&gt; &nbsp; &nbsp; return 0;<br>
&gt; }<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; Any clues?<br>
&gt; <br>
&gt; By the way, I noticed a &quot;cat /proc/xenomai/registry/pipes/rt2=
event |<br>
&gt; xxd&quot; won't work, perhaps due to the same reason?<br>
&gt; <br>
</tt><br>
<tt>---</tt><br>
<tt>Best regards,</tt><br>
<tt>Dmitry</tt><br>
</body></html>=

--0__=4EBBFA53DFAAC65B8f9e8a93df938690918c4EBBFA53DFAAC65B--


