Message-ID: <42D27CA4.5080308@domain.hid>
Date: Mon, 11 Jul 2005 16:05:24 +0200
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] LRTBF par-log.c & adeos_critical_enter question
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hi all! (Philippe? Kristian? :-)

Over the weekend I was pondering over the LRTBF par-log.c example and used
the circular buffer for one of my own examples:

One question arose - which actually causes a problem too:

In par-log.c in read_proc: why do you set disable_timer ?

In read_proc there is the while loop:

	flags = adeos_critical_enter (NULL);
	while (read_pos != write_pos && len <= (count - MAX_STR_LEN )) {
	[...]
	}
	adeos_critical_exit (flags);

After adeos_critical_enter, interrupts are disabled anyway (right?), so no
modification of read_pos or write_pos is possible and reading over the
proc file is not disturbed.

Furthermore in read_proc you reset disable_timer only after the complete
buffer was read via the proc file:

	if (read_pos == write_pos) {
		disable_timer = 0;

The problem:
While some user-space app is reading from the proc file, nothing is written
to the buffer and this causes data loss.

IMO, it would be best, if writing to the buffer is not disabled in read_proc.
In the actual data copying action in read_proc/while-loop no interrupt can
interfer - and if not everything from the buffer was read in the first place,
there is no problem if some data is added to the buffer until the next read
action occurs.

Maybe I'm overlooking something here - thanks for any comments and help! :-)

Best regards,
Hannes.

