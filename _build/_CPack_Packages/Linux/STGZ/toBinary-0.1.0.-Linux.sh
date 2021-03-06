#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the toBinary-0.1.0.-Linux subdirectory
  --exclude-subdir  exclude the toBinary-0.1.0.-Linux subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "toBinary Installer Version: 0.1.0., Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
MIT License

Copyright (c) 2020 kichyr

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

____cpack__here_doc____
    echo
    while true
      do
        echo "Do you accept the license? [yn]: "
        read line leftover
        case ${line} in
          y* | Y*)
            cpack_license_accepted=TRUE
            break;;
          n* | N* | q* | Q* | e* | E*)
            echo "License not accepted. Exiting ..."
            exit 1;;
        esac
      done
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the toBinary will be installed in:"
    echo "  \"${toplevel}/toBinary-0.1.0.-Linux\""
    echo "Do you want to include the subdirectory toBinary-0.1.0.-Linux?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/toBinary-0.1.0.-Linux"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +171 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the toBinary-0.1.0.-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
� q�^ �]t�}�ӷ,��&�6�"�l�|'�d�ؠ�t��%E�&���JZ|_�ۓ%���$A5nLix	�q^Ӕ����k)M]"j�i��<�P�&�QB�8�%u|������ܮd	K��γ�������Gjl�0���vo�zE�=[�n�7��o�z����#�=u^� z�[1��)MN�*���X�>�L�$��qP�a%�O��CccC���ݨ����=��O�������w�(p8�p�p��B'������giZ�&a1�+
k�1�x���_f���*�0�̾�����W�}�"KW̄y�#�f����D�s~���t�l�j�p�v���Gu�����u���f������,"�&�����t{H:�o�>-��׵�\�u�2����O��J�Kw�z{��6��b�٧�lsDhl�	�F�Xz�v������������T};;�Q�M �6����Q�[�Խ�n.�Ѳ��Z����#��VP�F ��|��2!۞�p_F⑌�ʿDSXZ�Ⱬ��ʣ���݈��G��//������蓲I��M�/��#��k�l�d�m䞴�+l��b�m�y�WY��TX%���p%i�E:.�=h�����¡�Qm$i(�Ihr�$I��}����T�Ԕ�$�v�E�1�O�(z�u�;{�d��s7<�j�T0ԫy<�a9)iIY� ������"����)-���`�����[��]���I
��z<�:=$RcC����+�y$���Kg+�����Շ���X4'ҩai@��tMj<@Ji�T����FG���L�crD�Ƥ����+�0�9G��x��Rh����xx�Ā4���G-�#H��Cj,,�(�tTA�!�Ġu�H��Ҡ�F$O�dMU5TQa�MIB��=Fe���mmR��-����Iu��������%��^�����:�XYD�+�_1�
�8YJF���?��Q����7�]�R}���ģu�rU]�F��,�R]�F���xL��̿~�@1�ϒ��>U�f�V�2��O=��x�-~�5������Ō����t�;���W3�9/g�I_�������|)�W�P�]��tC��r��¯a�Q¿T����apv�|�����������O28�y��K���1�����'���/2�b!��.����_,Y����.+��f�f>2�d��>Wv�g�� �����%kq�a���3�ɜ�a�d�p�Y#\��i��p�sF��1�%8|�.��F��e#���o��8�a��uҾ]�/�s�4�ra��Ņ���n.���۹��ײa���_�P`����?<���q��)(���ŷao����V,��N@��Bh�V�5Oi+�jZ�W��̹%k���;C|H���:�Ws10~>��Oo<;Up<x颶|�0(˜�zQz�ߑ�ђ)��?pt�=�E;0��vu���/@`r�b&3��x��uhD����D��C����Z���O��'ÁcE7Vc~�I�D��t`�yP������?�����/L~��?��iE���F�^�����y>�{2����n|c��gh©���+��O6!&G��s�]g���d����驣�/8�u���d�j@pdrr=��O6��*�c�C!��8�u��3����M>%���ʢ:0~�����|Y�c�V��/=�8:�^��Y���
1/E_>z�ea�''�~�Ʒ)U	���_C�h��-��F��CI��Q���hœ�:�
�Q���DP~j�����I�m���s�c@W�F�N@x���(�-/`:e�
��������O^ �'�� �G��bJ�N��@��H*��՛�z����9�]�7N3u�����R���o�lUB�
�����,yt
��-$�9��ǻ3�
Ȼkz3����/�L\'؋+����q7�A\:��z:,��i,s7m�iZ
��W�c,yJx��6��1�T�|���6�N<�PEN3��5�Aג��ɍ�g�t߾�&A�����?8�K_�o�B�x�z�{;j~����oB'<��Bm��d���c����?�e�/p�#��韠��λ|�|w�>��fE"yg�yטi�.��.��.��.��9�n�cU�-���<�ɜ���w�I���?��L���3�A��7�^c���?�q�ς��Lf
�σ_	�~��_f2{�O�?
���?���?~寀?�����|t >���}����3�	��K������
Ǫ�KːnGg��<��N��x�z=����g��;�+o_rա�#�m+�n�__E��C�����F��S��bp��=�X���|q� ����'��BY~�"	2�/��hA����� !��2�>�v#�4MA;N��߂�i������鑌������S��9������^��nC�>����x��>�OB��M�i��q�?�-&���IH��OC�y�_��ߙ��*Ŀ5�T���ڸ�4�_Yo��=�m��A�26>����.�_��w0���u��?�+ ~�T>Q� ��8�����/�W�A��\<^�/�~�����ђ@y��ҝ�-��&_��W^�Z.��W��W����o0E�N��E&�X�N�_|��IG1�����>�`��]��]��]��]����ס�s�y��2�wp�KU6����z�c�}�	��B��Ʌ�ħ���=s�ˋ|��$yO�k��=�r��ӳ'�"�ѳ:��_!�=S���S�go�HF�{=C�%�r���Ef��==#C����7���A��$<IdH��y���!�&��Δ�G�m��M*������O����O��'��}9����ƨ��ֶU��HǴ���syj��8TW���:����v7�����,�����f��8nƋ��,�b�}���]��R����2�]��EF{2�N�ݚ��mƯ6�3�łh���,�%�yK�°�0�K��Č/�<�\(\c��7�˅-�¹uV��Ƹe��g�Wf�Ҳ��(H�3�2khb³����L���y��Ѹ\ �y�+�r��o x�o�2V	{Z��ہ�s�!J���������������	E�Y�i��^N�o���|����Kp:���h�cz�Ŝ\�r^�@q˅W-ڏU�M�an��|�6�݆�綫 �smN��%8_��'�>`s���t��Bx�L�-/��W
�-���R�s�s9>���t����n����ƉR_ xs��ϫDj(��?|�!�7��̙z���Y�ǀ� |��_:�N���� w\*.���%��?Xd�������h�ו��F�Oj��b]���z�_ �������SY�X�}�D/g�=�U����7�v���R�]���ρ�U��V3�\j���R��n��+�^>L���t����Y��b�^�t!���mҿV��}�ȥg�Xdmg�G���<�H�� r����"k;�WI�O�q��>c��S�s��m'�:���}��Nk�B(�����+$d�x$-*���NJ��p\�����ɔ$�G�P<��(�v5��^�D�HC��dR�����rT���htH��)5SRd;�
%����ӜP��rHM)R(Ki�tHӣ�$I�#r6x�툦�0C��@(��XX
+:
�UU�vvt��:�$= u�5&'Ǥ��ЅK;z|�����;I;;�%����Aj����l�8S�f ���v����I}����C���6(�7K�P,��m"Z�;4�p�LJ� e,��B�P�2T1�����JX�dA
v˰��)%�����!*�f�JJ�AFW+QsU��Y�`=u+$,+�f�JْI�`pO*٫5J������X\����Ր��44V)�P ��T�� ��0�If�jb=M4VN��!,G���9�V�#�m,��{���C)��Kà �n��� ��9m�pj��+��l��@HRT���D���޹%��)#j��ˍ16�m��l�h��y��DB��5/��
�D�(��wOcR��
�!�4��zG�ꭓr�����Է�����1g����4 CJl��I:��ըt�:V��@��mIZ��mc�xT�C!%�28K�<�9 S��V�\�ƞ�TZ�g|�����1�D��@�!��C��ؼe�so6�zh�-9:�{v���`Bm���� ��LA�E�a��w��:-ފ�4=J"��`m��C�^���s�g�!o~�)�-�sL�m��-L�͙\���&��%u�>�1`�\�*P\�W"�V��1�@Z��k�0��բ6���԰�
��@��kI=�"(OS@����QB�hHh���5')%$�`�� �GW2��a.e�,����lĄB�2R� T6��*S�A�A�U���z���U{���k�l�^�^i込�=+�9�0ږamj������&m����E�s��}� GO�ﳑ��#�_e2qJO���O���Ax�eA�B��~2��H�Q{dJO�W���N��L}���:��
�7���OS����=�Ǧ�	!������^����wS�~��ˏ��S��n?�}q�1��Y������5wo�F_��s�t���\z�z�?���~<��mx��GO���Ϟ���[���OQ�߸��>_���~�y�r���&���b�N���9z��~��������+���u��~���Z.=����='*Ƹ?��'ėw�:�{(=�o�Z��ӣ}��޸��'+��^A����O68O� ��a�76��I�)OO��a�����JB�"G������8���;'� ��O�1�]�+�?��Y�D�����Ƿ��6�ɅZ�8�~�,+������?.�C�?����A�GcC�]�ף����P�^��1��B�������͢ٹs��&���%���Sdɶ��.�����}lR\I�F�_6�; ��g�?ؼ��������R?f�z�^���38O}��4ru�7;7�ͩ��4�cn�Fo#���;� ��������[،Ӣ#+}�|-��km%yF�	+�3�C�]דg��_K�E��@�*�#>ڧ��<�����K��)n}M����E�;:L���c�5-z|�����`���l���L�� (����D��ڂ�Y%ɹ�EO���B�3�ڢg˸QE^�[[�e\ڭ-�E�5�m���J��)e��EG�[[��խ-z3��YP��f�]̱�E���ʞ��y5#���v�����G���l�#�-�n�N�qog{z�WI������&����6ogg�o��H������;��\��&T�>l_(X��9k���~gq�)�59�u|�~�nq�[��S[��n:�s�M��\��o���N�"��P0���F�����7��m�j�z׮�r�Q�o�ƭ�P
kK��w������P�0bt�k�*�j<��ZT�˘�E�Wv
�p���w����+6���a���s��~G�#�&��k|��o��6|.;ۯiI��x�_�s��B�g�u��l��=���^����1������r|�Y��s��~MG�oa<ۯ��h7>�������?a<�ߍ��?�9�1�w��d{�s�w�_�������s���?h��wo��>�>���]~�.�a�߰{�n�+Q�2D����|���������e�Z?��.��of�/1���Y���V�g�^>��������;����b�-�2x��m�_�����'�ڤg�-~�M�oc��6x�ζ�^�߀<B��7X�t3�W38�v�ap��e��ٷ���}{y��MG��ٷ�Ig�^�4��o/�����;)�ή�bpv��	gw^dp���4�i�V��*s��]�=�j�w-��/+�J_�qt�,�Lj-�
�B��^��em��t|M/��n~����қg1aV�lWV\_�KFb� 6zrE�!9�nð��#vv���bK�
̜1ZH��	��]%��nx��\[K~t��v�ħkD[7�>�����oA�0�����Y�S�V~�,�X�o����7͂�Q��Y��oX,��Y�ނ~�,�$>[~�̂�i��-�E��{ �9�?����U���2SWM��|����=�$p羉{��2o��gK���nSz>=n��?J�_�x�n��p!	�r�y�])�~��=GF叾.���6�r��tX�S{�s�yztߍ��n�)�� ��g�?�n�J�	�� ���Z��O�#�VvC������/�|;����_������B����Yh-%�P�z���Qh-_$b����B��l���n�/?o�5����"��?nC�(���!���ZlM�g6����nC�w�~�K��7[��0Q|?	��Geɗ���B���LvvC�}�F��+�r���,�W�X�ݴe�X���\Wbm���h�O[S���\�Kz�����J�����'���Vb=�#�G�uP9lr����(A&���'}��jU�vvG�d�p�[\��Q�|:>�~7�E�ae^m�fo�U__���-�����N\�M ⦷�r��[H��tP��u�����B�u�����[�YD�œ�6���tn�,Z����N�R�ބ ��"���8��(11���(IQN����s���֭����t�)aq��w���߹PT>0������4z���B8��iϫ�c����M�����k������.o�� n��S���00���m���Nu��j��m�}���n��]=����`W�a�;�J�����u.o�SŨ�J�CJ�_��C���t��U��x�vH��r�<q0�&�pU�S��Ab�7;)�������� i�A�s]�;tN6�r��MT��xRՈ�r@P[<�c���Ę��x ?$jÊ8�>�i"����L)Z�^����]=}Ҏ`�����A��qM	i�<$���&F�MMDO߈�&��04Z�P<	��D$ 0ˑ�"��H.�*8�0)'Q���B��']��hWU��kL`g\3��hS�}z|���ȡa>Ƙ�Q���)������ly��{9�0"�&���'��zv��l�p�sT�!����K�>-���8Яz�z����u�U9�R��;XY��֓�SW�8m�C	̽��a��:ەI�̐%���`��*b�@Zcqh�H��L�t5%����!5]Үú ׾m?D�V1W�l"$gx�sg��3�M�ۗ�]��!"��< �y��װTGE��V�e49p���	H�)�n�C�=�c�r��������#�y[O���O���5���냑����J�K����U�e���De 5E��L�@��	]����j
�__�M��ہ"�/��ݪ��t�tu�{���^P*������k��������ڃ=��������f�zT��w��0T�>��ڂ'uiZ��}Q�N��5r/��i5�Uۺ:ww�X]S�p�_��n�WsU�qx�6K���z����;x��P�D9�N����∜T����"L�D�&����/��)��X�w��4f���Տ�rHKC�1��0���V������m���˽�E���7����R�������T�$���1���cm����6���཯J4����	�"����}UN4��X�}�Yw�bw<�BGG�����R���:7�}��x^��
��}$D-
��C&x�!�a�trDo~D_�6N�4��+!%���4���2��x1����P;.��y��C���F�2�E�pC�d4���۵nR d�7
��1��rV����M-՘�f�~��[Q�慛r_n=�������p�jJ_|�#
0P`�OX�$�Q��T*���J��6�Ʉ�V���2-"��8�ƭ'Wc�d/�b9��K[V�o4���/'y7�����6��3��{�������.����w�-:��H4����
/�L�6X��u%==I_�U%y$�˽�zTҗZ�=�J���;�t�fv�Tʭ#عK�.Z;|�;�};a~�|Ū�={�L$]mX6�$wY�s bedz��� �%P3M��l$�$%Ě����N�wy�wy�.���+  �  