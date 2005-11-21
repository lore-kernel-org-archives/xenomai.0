Message-ID: <43819D68.4000800@domain.hid>
Date: Mon, 21 Nov 2005 11:11:52 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] pipe fun
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

This has to be something really simple but I'm hitting a wall. I have a
rt module that creates a pipe and periodically writes some data to it.
In the following program, the read fails with "No space left on device":


int main (void) {

    int r, fd; u_char c;

    fd = open("/proc/xenomai/registry/pipes/rt2event", O_RDWR);
    if (fd < 0) {
        fprintf(stderr, "ERROR opening pipe: %s\n", strerror(errno));
        return -1;
    }

    for (;;) {
        r = read(fd, &c, sizeof(c));
        if (r == 0) { fprintf(stderr, "ERROR reading (returned 0)\n");
break; }
        if (r < 0) { fprintf(stderr, "ERROR reading: %s\n",
strerror(errno)); break; }
        fprintf(stderr, "%02hX ", c);
    }

    close(fd);

    return 0;
}


However, the following program works fine!!!


int main (void) {

    int r; u_char c;

    FILE *f;

    f = fopen("/proc/xenomai/registry/pipes/rt2event", "r+b");
    if (f == NULL) {
        fprintf(stderr, "ERROR opening pipe: %s\n", strerror(errno));
        return -1;
    }

    for (;;) {
        r = fread(&c, sizeof(c), 1, f);
        if (r == 0) { fprintf(stderr, "ERROR reading (returned 0)\n");
break; }
        if (r < 0) { fprintf(stderr, "ERROR reading: %s\n",
strerror(errno)); break; }
        fprintf(stderr, "%02hX ", c);
    }

    fclose(f);

    return 0;
}



Any clues?

By the way, I noticed a "cat /proc/xenomai/registry/pipes/rt2event |
xxd" won't work, perhaps due to the same reason?

