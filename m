From: Umair Ali <ali.umair@tut.fi>
Date: Tue, 8 Dec 2015 17:25:21 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A70DB46@mb2010-1.intra.tut.fi>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Loose determinism when reading pcap and sending as raw
 ethernet packets
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi there,

I am reading the pcap file using the following technique:
"
mlockall(MCL_CURRENT|MCL_FUTURE);
fd =3D open (file.pcap, O_RDONLY);
status =3D fstat (fd, & s);
size =3D s.st_size;
 /* Memory-map the file. */
 mapped =3D mmap (0, size, PROT_READ, MAP_PRIVATE, fd, 0);"


Then i have the pcap file in mapped variable in the form of chracters (hex =
numbers). I read packet by packet and send them as raw packet over the netw=
ork with following code:
"struct timespec ts;
ts.tv_sec =3D 0;
ts.tv_nsec =3D 5000;
j=3D24;

 while (j < size){
         i =3D (unsigned char) mapped[j + 8];
         sendto(sock, &mapped[j+16], i, 0,(struct sockaddr *)&peer, sizeof(=
peer));
         nanosleep(&ts, NULL);
          j =3D j+i+16;
}
"

When i run the program and receive the packets on the receiver then i have =
observed that behaviour of sending raw packets is not constant. Sometimes n=
anosleep finish little late or quickly.
The slackspot output file is attached for reference. Please guide that what=
 am i doing wrong.


Thanks & Regards
Ali

-------------- next part --------------
A non-text attachment was scrubbed...
Name: slackspot_output
Type: application/octet-stream
Size: 8999 bytes
Desc: slackspot_output
URL: <http://xenomai.org/pipermail/xenomai/attachments/20151208/3763c1b0/at=
tachment.obj>
