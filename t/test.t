$| = 1; # nicer to pipes
$\ = "\n"; # less to type?

my @test = ( # a series of test subs, which return true for success, 0 otherwise
	sub { require MPEG::Audio::Frame }, # see if it actually loads
	sub {
		my $frame = MPEG::Audio::Frame->read(\*DATA) || return undef; # read the next frame from the data bit
		
		return undef unless (
			not defined $frame->crc and
			$frame->bitrate() == 128 and
			$frame->sample() == 44100 and
			int($frame->seconds()*10000) == 261 and
			$frame->length() == 418 and
			not $frame->broken and
		1);
		
		1; # we made it
	},
	sub {
		my $frame = MPEG::Audio::Frame->read(\*DATA) || return undef; # read the next frame from the data bit
		
		return undef unless (
			defined $frame->crc() and
			$frame->bitrate() == 224 and
			$frame->sample() == 44100 and
			int($frame->seconds()*10000) == 261 and
			$frame->length() == 731 and
			not $frame->broken and
		1);
		
		1; # we made it
	},
	sub { return undef if MPEG::Audio::Frame->read(\*DATA); 1 }
);

print "1..", scalar @test; # the number of tests we have

my $i = 0; # a counter

foreach (@test) { print (((&$_) ? "" : "not ") . "ok " . ++$i) } # test away

__DATA__
the following data is used to test the module.

and mp3 header and frame will follow this (text|garbage)
and will be parsed and munged and whatever.

here goes nothing...



���@     7�     �      �      �                                                                                                                                                                                                                                                                                                                                                                                                 



this is more garbage to be ignored


dgskjhag
�����  ɊH&N  ��H��H e�"=� 
j��K��    �c�� :#f;+\��o >���5g��bq�O�
P(�%1s��������?��&.A�"69�O����'l��������y+�a*r.W"�S����"��P�hO�f������������P�r.nE��|�n\.x
Si���*��o�G�@0 ��<N���o |� �Y�8�� �	L\���1da8�ȟ��,��"�9 � ���,��"c0A
��@Ș������x����6A��r�����������ό�7 �Pо_7�p�0�0�
�D�=1s��A%Yh���R���O���A0�=A��E$�����afbI%EM$��ffk�RUUz���U�j��[�<L�)��}JU��}k�o<��Գ��ZC#��3[G�����2��.lӠ�5�5Ts��eC��4�VUo��khY�4u0�L<
(�F�h"���̰T�B��8�ӵ����T�4�S�S3�����C��̔�5Egh������&ٗ.
��|pю�u-�:��[^���R�ߨ�Mm���e$���MTP���
�y
:�~]��9�&oR�L�P�FP6��]���A>etMC#��=3�L�sBphq��\�`�YF
	��0��Ѐ��sh>���!h��BY�t��4b�����`Y�(nQ�&<����

dgk���uwj more �ʬĩϫgarbage&&$Y n4bn�oet
